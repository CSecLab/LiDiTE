package it.unige.fdt.scriptablesensor.services.lut;

import java.util.concurrent.ScheduledExecutorService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.feature.lut.LUTFeature;
import it.unige.fdt.scriptablesensor.model.feature.lut.LUTFeatureComponent;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValue;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValueFromJavascript;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValueTimeBased;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValueWeekdayTimeBased;
import it.unige.fdt.scriptablesensor.services.FeatureComponentScheduler;
import it.unige.fdt.scriptablesensor.services.lut.value.SensorLUTJSFeatureService;
import it.unige.fdt.scriptablesensor.services.lut.value.SensorLUTTimeBasedFeatureService;
import it.unige.fdt.scriptablesensor.services.lut.value.SensorLUTWeekdayTimeBasedFeatureService;
import it.unige.fdt.scriptablesensor.utils.ExecutorsFactory;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorLUTFeatureComponentService implements FeatureComponentScheduler<LUTFeature, LUTFeatureComponent> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorLUTFeatureComponentService.class);

    @Inject
    ScheduledExecutorService executorService;

    @Inject
    SensorLUTJSFeatureService jsFeatureService;

    @Inject
    SensorLUTTimeBasedFeatureService timeBasedFeatureService;
    
    @Inject
    SensorLUTWeekdayTimeBasedFeatureService weekdayTimeBasedFeatureService;

    private void runFeatureComponentValueCalculation(String featureName, String componentName,
	    LUTFeatureComponentValue featureComponentValue) {
	LOGGER.debug("Starting calculation for {}/{}", featureName, componentName);
	if (featureComponentValue instanceof LUTFeatureComponentValueFromJavascript) {
	    LUTFeatureComponentValueFromJavascript javascriptComponentValue = (LUTFeatureComponentValueFromJavascript) featureComponentValue;
	    jsFeatureService.calculateFeature(featureName, componentName, javascriptComponentValue);
	} else if (featureComponentValue instanceof LUTFeatureComponentValueTimeBased) {
	    LUTFeatureComponentValueTimeBased timeBasedComponentValue = (LUTFeatureComponentValueTimeBased) featureComponentValue;
	    timeBasedFeatureService.calculateFeature(featureName, componentName, timeBasedComponentValue);
	} else if (featureComponentValue instanceof LUTFeatureComponentValueWeekdayTimeBased) {
		LUTFeatureComponentValueWeekdayTimeBased lutFeatureComponentValueWeekdayTimeBased = (LUTFeatureComponentValueWeekdayTimeBased) featureComponentValue;
		weekdayTimeBasedFeatureService.calculateFeature(featureName, componentName, lutFeatureComponentValueWeekdayTimeBased);
	} else {
	    throw new IllegalArgumentException(featureComponentValue.getClass().getName());
	}
	LOGGER.debug("Completed calculation for {}/{}", featureName, componentName);
    }

    @Override
    public void scheduleFeatureComponent(String featureName, LUTFeature feature, LUTFeatureComponent component) {
	ExecutorsFactory.scheduleAtFixedRate(executorService, LOGGER,
		() -> runFeatureComponentValueCalculation(featureName, component.getName(), component.getValue()),
		feature.getUpdateFrequency());
    }
}
