package it.unige.fdt.scriptablesensor.simulation.stephandlers;

import java.util.Arrays;
import java.util.stream.Collectors;

import org.apache.commons.math3.ode.sampling.FixedStepHandler;
import org.apache.commons.math3.ode.sampling.StepHandler;
import org.apache.commons.math3.ode.sampling.StepNormalizer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Named;
import jakarta.inject.Singleton;

@ApplicationScoped
public class StepPrinter implements FixedStepHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(StepPrinter.class);

    @Produces
    @Named("printer")
    @Singleton
    public StepHandler getInstance() {
	return new StepNormalizer(0.1, new StepPrinter());
    }

    @Override
    public void init(double t0, double[] y0, double t) {
	if (LOGGER.isDebugEnabled()) {
	    LOGGER.debug(String.format("Beginning integration for t = %.2f to %.2f", t0, t));
	}
    }

    @Override
    public void handleStep(double t, double[] y, double[] yDot, boolean isLast) {
	if (LOGGER.isDebugEnabled()) {
	    String stateString = Arrays.stream(y).mapToObj(Double::toString).collect(Collectors.joining(", "));
	    LOGGER.debug(String.format("t = %.2f, state = %s", t, stateString));
	}
    }

}
