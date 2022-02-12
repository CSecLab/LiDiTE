package it.unige.fdt.scriptablesensor.services.lut.value;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.Sensor;
import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValueFromJavascript;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptCallbackService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Event;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorLUTJSFeatureService
	implements SensorLUTComponentValueCalculator<LUTFeatureComponentValueFromJavascript> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorLUTJSFeatureService.class);

    @Inject
    Event<SensorFeatureUpdateMessage<?>> featureUpdateBus;

    @Inject
    JavascriptCallbackService jsCallbackService;

    @Inject
    Sensor sensor;

    @Override
    public void calculateFeature(String featureName, String componentName,
	    LUTFeatureComponentValueFromJavascript componentValue) {
	// Grab value
	LOGGER.debug("Starting JS calculation for {}/{}", featureName, componentName);
	Object value = jsCallbackService.callFunction(componentValue.getFunctionName(), Object.class);
	// Post update
	if (value != null) {
	    LOGGER.debug("Performed JS calculation for {}/{} = {}", featureName, componentName, value);
	    featureUpdateBus.fire(new SensorFeatureUpdateMessage<>(value, featureName, componentName));
	} else {
	    LOGGER.warn("JS calculation for {}/{} returned null", featureName, componentName);
	}
    }
}
