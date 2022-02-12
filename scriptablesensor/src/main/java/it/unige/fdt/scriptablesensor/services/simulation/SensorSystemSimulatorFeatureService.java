package it.unige.fdt.scriptablesensor.services.simulation;

import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ScheduledExecutorService;
import java.util.stream.Stream;

import org.apache.commons.math3.ode.FirstOrderIntegrator;
import org.apache.commons.math3.ode.events.EventHandler.Action;
import org.apache.commons.math3.ode.sampling.StepHandler;
import org.apache.commons.math3.ode.sampling.StepNormalizer;
import org.eclipse.microprofile.config.Config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.SystemSimulatorFeature;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.SystemSimulatorFeatureEventHandlers;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.SystemSimulatorFeatureGStopHandler;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.SystemSimulatorFeatureStepHandler;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptCallbackService;
import it.unige.fdt.scriptablesensor.services.FeatureScheduler;
import it.unige.fdt.scriptablesensor.simulation.equations.DerivedEquation;
import it.unige.fdt.scriptablesensor.simulation.eventhandlers.GStopFacility;
import it.unige.fdt.scriptablesensor.simulation.stephandlers.EndTimeStepHandler;
import it.unige.fdt.scriptablesensor.simulation.stephandlers.JavaScriptStepHandler;
import it.unige.fdt.scriptablesensor.utils.ExecutorsFactory;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Event;
import jakarta.inject.Inject;
import jakarta.inject.Named;

@ApplicationScoped
public class SensorSystemSimulatorFeatureService implements FeatureScheduler<SystemSimulatorFeature> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorSystemSimulatorFeatureService.class);

    @Inject
    Config config;

    @Inject
    Event<SensorFeatureUpdateMessage<?>> featureUpdateEventBus;

    @Inject
    ScheduledExecutorService executorService;

    @Inject
    @Named("printer")
    StepHandler stepPrinter;

    @Inject
    JavascriptCallbackService jsCallbackService;

    private class SimulatorState {

	public final String featureName;
	public final SystemSimulatorFeature feature;

	public final double[] lastState;

	public double lastTime = 0.0;

	public final FirstOrderIntegrator integrator;

	public SimulatorState(String featureName, SystemSimulatorFeature feature) {
	    this.featureName = featureName;
	    this.feature = feature;
	    // Initialize state
	    this.lastState = feature.getInitialState();
	    // Initialize integrator
	    this.integrator = feature.getIntegratorSettings().buildIntegrator();
	    // Add base step handlers
	    this.integrator.addStepHandler(stepPrinter);
	    this.integrator.addStepHandler(new EndTimeStepHandler(t -> {
		LOGGER.debug("Setting ending time to: {}", t);
		this.lastTime = t;
	    }));
	    // Settings
	    double maxTimeBetweenChecks = feature.getIntegratorSettings().getCheckMaxTimeBetween();
	    double checkTolerance = feature.getIntegratorSettings().getCheckTolerance();
	    int checkMaxIterations = feature.getIntegratorSettings().getCheckMaxIterations();
	    // Register step handlers
	    for (SystemSimulatorFeatureStepHandler stepHandler : feature.getStepHandlers()) {
		JavaScriptStepHandler generatedStepHandler = new JavaScriptStepHandler(stepHandler.getFunctionName(),
			jsCallbackService);
		stepHandler.getFixedStep().ifPresentOrElse(step -> {
		    // Perform normalization
		    StepHandler normalizedStepHandler = new StepNormalizer(stepHandler.getFixedStep().get(), generatedStepHandler);
		    this.integrator.addStepHandler(normalizedStepHandler);
		}, () -> this.integrator.addStepHandler(generatedStepHandler));
	    }
	    LOGGER.info("Added {} step handlers", feature.getStepHandlers().size());
	    // Register event handlers
	    SystemSimulatorFeatureEventHandlers eventHandlers = feature.getEventHandlers();
	    for (SystemSimulatorFeatureGStopHandler gStopHandler : eventHandlers.getgStopHandlers()) {
		// Bind handler
		GStopFacility gStopBaseFacility = new GStopFacility(gStopHandler.getStateIndex(),
			gStopHandler.getThreshold(), gStopState -> {
			    String result = jsCallbackService.callFunction(gStopHandler.getFunctionName(), gStopState,
				    String.class);
			    return Action.valueOf(result);
			});
		switch (gStopHandler.getDirection()) {
		case ANY:
		    this.integrator.addEventHandler(gStopBaseFacility, maxTimeBetweenChecks, checkTolerance,
			    checkMaxIterations);
		    break;
		case DECREASING:
		    this.integrator.addEventHandler(gStopBaseFacility.forDecreasingEvents(), maxTimeBetweenChecks,
			    checkTolerance, checkMaxIterations);
		    break;
		case INCREASING:
		    this.integrator.addEventHandler(gStopBaseFacility.forIncreasingEvents(), maxTimeBetweenChecks,
			    checkTolerance, checkMaxIterations);
		    break;
		default:
		    throw new IllegalArgumentException(gStopHandler.getDirection().toString());
		}
	    }
	    LOGGER.info("Added {} g-stop handlers", eventHandlers.getgStopHandlers().size());
	}

	public void ensureJSObjectsAreBound() {
	    jsCallbackService.bindObject("systemDefinition", feature.getSystemDefinition());
	    jsCallbackService.bindObject("systemState", this.lastState);
	    jsCallbackService.bindObject("systemTime", this.lastTime);
	}
    }

    @Override
    public void scheduleFeature(String featureName, SystemSimulatorFeature sensorSimulatorFeature) {
	SimulatorState state = new SimulatorState(featureName, sensorSimulatorFeature);
	ExecutorsFactory.scheduleAtFixedRate(executorService, LOGGER, () -> simulateFeature(state),
		sensorSimulatorFeature.getStateRefreshIntervalSeconds());
    }

    private CompletableFuture<Void> handleJavaScriptMapping(SimulatorState state, Map.Entry<String, String> entry) {
	// Extract map entry
	String propertyName = entry.getKey();
	String jsFunctionName = entry.getValue();
	// Convert to future
	return CompletableFuture
		.supplyAsync(() -> jsCallbackService.callFunction(jsFunctionName, Object.class), executorService)
		// Create update message
		.thenApplyAsync(res -> new SensorFeatureUpdateMessage<>(res, state.featureName, propertyName),
			executorService)
		// Fire event
		.thenAcceptAsync(featureUpdateEventBus::fire, executorService);
    }

    private CompletableFuture<Void> handleCalculationMapping(SimulatorState state,
	    Map.Entry<String, DerivedEquation> entry) {
	// Extract map entry
	String propertyName = entry.getKey();
	DerivedEquation derivedEquation = entry.getValue();
	// Convert to future
	return CompletableFuture
		.supplyAsync(() -> derivedEquation.calculateValue(state.lastState,
			state.feature.getSystemDefinition().getU().toArray()), executorService)
		// Create update message
		.thenApplyAsync(value -> new SensorFeatureUpdateMessage<>(value, state.featureName, propertyName),
			executorService)
		// Fire event
		.thenAcceptAsync(featureUpdateEventBus::fire, executorService);
    }

    private CompletableFuture<Void> handleStateMapping(SimulatorState state, Map.Entry<String, Integer> entry) {
	// Extract map entry
	String propertyName = entry.getKey();
	Integer index = entry.getValue();
	// Convert to future
	return CompletableFuture.supplyAsync(() -> state.lastState[index], executorService)
		// Create update message
		.thenApplyAsync(value -> new SensorFeatureUpdateMessage<>(value, state.featureName, propertyName),
			executorService)
		// Fire event
		.thenAcceptAsync(featureUpdateEventBus::fire, executorService);
    }

    private void simulateFeature(SimulatorState state) {
	state.ensureJSObjectsAreBound();
	double endingTime = state.lastTime + state.feature.getStateRefreshIntervalSeconds();
	state.integrator.integrate(state.feature.getSystemDefinition(), state.lastTime, state.lastState, endingTime,
		state.lastState);
	// Run end handlers
	state.feature.getEndHandlers().parallelStream().forEach(jsCallbackService::callFunction);
	// Run feature mappings
	/// Generate event handling futures
	Stream<CompletableFuture<Void>> completableFutures = Stream.empty();
	completableFutures = Stream.concat(completableFutures, state.feature.getFeatureMappings()
		.getFromJavaScriptMappings().entrySet().parallelStream().map(e -> handleJavaScriptMapping(state, e)));
	completableFutures = Stream.concat(completableFutures, state.feature.getFeatureMappings().getFromStateMappings()
		.entrySet().parallelStream().map(e -> handleCalculationMapping(state, e)));
	completableFutures = Stream.concat(completableFutures, state.feature.getFeatureMappings()
		.getStateVariableMappings().entrySet().parallelStream().map(e -> handleStateMapping(state, e)));
	/// Wait until each one terminates
	CompletableFuture<Void> masterFeature = CompletableFuture.allOf(completableFutures.toArray(CompletableFuture[]::new));
	try {
	    masterFeature.get();
	} catch (InterruptedException | ExecutionException e) {
	    LOGGER.error("Failed updating feature", e);
	}
    }
}
