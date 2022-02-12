package it.unige.fdt.scriptablesensor.services.lut.value;

import java.time.LocalDateTime;
import java.time.temporal.ChronoField;

import org.apache.commons.math3.analysis.UnivariateFunction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValueTimeBased;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Event;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorLUTTimeBasedFeatureService
	implements SensorLUTComponentValueCalculator<LUTFeatureComponentValueTimeBased> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorLUTTimeBasedFeatureService.class);

    @Inject
    Event<SensorFeatureUpdateMessage<?>> featureUpdateBus;

    private static double getCurrentMinuteInDay() {
	return LocalDateTime.now().get(ChronoField.MINUTE_OF_DAY);
    }

    @Override
    public void calculateFeature(String featureName, String componentName,
	    LUTFeatureComponentValueTimeBased componentValue) {
	LOGGER.debug("Starting time based interpolation for {}/{}", featureName, componentName);
	// Get interpolating function
	UnivariateFunction interpolatingFunction = componentValue.getLut().getInterpolatingFunction();
	// Calculate the value
	double currentMinuteInDay = getCurrentMinuteInDay();
	double value = interpolatingFunction.value(currentMinuteInDay);
	LOGGER.debug("Time based interpolation for {}/{}: x = {}, y = {}", featureName, componentName,
		currentMinuteInDay, value);
	// Submit update to event bus
	featureUpdateBus.fire(new SensorFeatureUpdateMessage<>(value, featureName, componentName));
    }

}
