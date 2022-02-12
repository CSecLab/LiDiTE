package it.unige.fdt.scriptablesensor.services.lut.value;

import java.time.DayOfWeek;
import java.time.LocalDateTime;
import java.time.temporal.ChronoField;

import org.apache.commons.math3.analysis.UnivariateFunction;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValueWeekdayTimeBased;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Event;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorLUTWeekdayTimeBasedFeatureService
	implements SensorLUTComponentValueCalculator<LUTFeatureComponentValueWeekdayTimeBased> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorLUTWeekdayTimeBasedFeatureService.class);

    @Inject
    Event<SensorFeatureUpdateMessage<?>> featureUpdateBus;

    private static DayOfWeek getCurrentDayOfWeek() {
    	return LocalDateTime.now().getDayOfWeek();
    }
    
    private static double getCurrentMinuteInDay() {
    	return LocalDateTime.now().get(ChronoField.MINUTE_OF_DAY);
    }

    @Override
    public void calculateFeature(String featureName, String componentName,
    		LUTFeatureComponentValueWeekdayTimeBased componentValue) {
	LOGGER.debug("Starting day of week time based interpolation for {}/{}", featureName, componentName);
	// Get interpolating function
	DayOfWeek dayOfWeek = getCurrentDayOfWeek();
	UnivariateFunction interpolatingFunction = componentValue.getLut().getInterpolatingFunction(dayOfWeek);
	// Calculate the value
	double currentMinuteInDay = getCurrentMinuteInDay();
	double value = interpolatingFunction.value(currentMinuteInDay);
	LOGGER.debug("Day of week time based interpolation for {}/{}: dow = {}, x = {}, y = {}", dayOfWeek, featureName, componentName,
		currentMinuteInDay, value);
	// Submit update to event bus
	featureUpdateBus.fire(new SensorFeatureUpdateMessage<>(value, featureName, componentName));
    }

}
