package it.unige.fdt.scriptablesensor.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.Sensor;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorFeaturesService {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorFeaturesService.class);

    @Inject
    Sensor sensor;

    @Inject
    SensorFeatureService sensorFeatureService;

    public void scheduleFeatures() {
	sensor.getFeatures().forEach(sensorFeatureService::scheduleFeature);
	LOGGER.debug("Scheduled {} features", sensor.getFeatures().size());
    }
}
