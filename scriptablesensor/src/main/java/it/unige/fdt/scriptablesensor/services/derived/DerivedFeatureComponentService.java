package it.unige.fdt.scriptablesensor.services.derived;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ScheduledExecutorService;

import org.eclipse.ditto.client.DittoClient;
import org.eclipse.ditto.json.JsonFieldSelector;
import org.eclipse.ditto.json.JsonValue;
import org.eclipse.ditto.model.things.Feature;
import org.eclipse.ditto.model.things.Features;
import org.eclipse.ditto.model.things.Thing;
import org.eclipse.ditto.model.things.ThingId;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import it.unige.fdt.scriptablesensor.model.feature.derived.DerivedFeature;
import it.unige.fdt.scriptablesensor.model.feature.derived.DerivedFeatureComponent;
import it.unige.fdt.scriptablesensor.model.feature.derived.DerivedFeatureComponentSource;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptCallbackService;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptTranslator;
import it.unige.fdt.scriptablesensor.services.FeatureComponentScheduler;
import it.unige.fdt.scriptablesensor.utils.ExecutorsFactory;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Event;
import jakarta.inject.Inject;

@ApplicationScoped
public class DerivedFeatureComponentService implements FeatureComponentScheduler<DerivedFeature, DerivedFeatureComponent> {

    private static final Logger LOGGER = LoggerFactory.getLogger(DerivedFeatureComponentService.class);

    @Inject
    DittoClient dittoClient;

    @Inject
    JavascriptCallbackService jsCallbackService;

    @Inject
    ScheduledExecutorService executorService;

    @Inject
    Event<SensorFeatureUpdateMessage<Object>> featureUpdateMessageBus;

    private JsonValue grabThingProperty(ThingId sourceThingId, String sourceFeatureName, String sourcePropertyPointer) {
	// Grab source thing
	Thing sourceThing = dittoClient.twin().forId(sourceThingId)
		.retrieve(JsonFieldSelector.newInstance("/features/" + sourceFeatureName)).join();
	Features sourceFeatures = sourceThing.getFeatures().orElseThrow();
	Feature sourceFeature = sourceFeatures.getFeature(sourceFeatureName).orElseThrow();
	JsonValue sourceFeatureValue = sourceFeature.getProperty(sourcePropertyPointer).orElseThrow();
	if (LOGGER.isDebugEnabled()) {
	    LOGGER.debug("Sourced feature {} {} {} = {}", sourceThingId, sourceFeatureName, sourcePropertyPointer,
		    sourceFeatureValue);
	}
	return sourceFeatureValue;
    }

    private JsonValue grabThingProperty(DerivedFeatureComponentSource source) {
	// Unpack source
	ThingId sourceThingId = ThingId.of(source.getThingId());
	String sourceFeatureName = source.getFeature();
	String sourcePropertyPointer = source.getPointer();
	return grabThingProperty(sourceThingId, sourceFeatureName, sourcePropertyPointer);
    }

    private void recalculateComponent(String featureName, DerivedFeatureComponent component) {
	// Gather sources
	List<Object> callbackPayloads = new ArrayList<>(component.getSources().size());
	for (DerivedFeatureComponentSource source : component.getSources()) {
	    callbackPayloads.add(grabThingProperty(source));
	}
	// Invoke callback
	Object[] args = callbackPayloads.stream().map(JavascriptTranslator::prepareForJavaScript)
		.toArray(i -> new Object[i]);
	Object result = jsCallbackService.callFunction(component.getCallbackName(), Object.class, args);
	// Send update message
	featureUpdateMessageBus.fire(new SensorFeatureUpdateMessage<>(result, featureName, component.getName()));
    }

    @Override
    public void scheduleFeatureComponent(String featureName, DerivedFeature derivedFeature, DerivedFeatureComponent feature) {
	ExecutorsFactory.scheduleAtFixedRate(executorService, LOGGER, () -> recalculateComponent(featureName, feature), derivedFeature.getUpdateFrequency());
    }
}
