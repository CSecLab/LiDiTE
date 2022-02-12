package it.unige.fdt.scriptablesensor.services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.Sensor;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorService {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorService.class);

    @Inject
    Sensor sensor;

    @Inject
    SensorFeaturesService sensorFeaturesService;

    public void startSimulation() {
	LOGGER.info("Starting simulation of sensor: {}", sensor);
	sensorFeaturesService.scheduleFeatures();
    }
}
