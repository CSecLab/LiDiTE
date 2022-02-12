package it.unige.fdt.scriptablesensor.services.lut;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.feature.lut.LUTFeature;
import it.unige.fdt.scriptablesensor.model.feature.lut.LUTFeatureComponent;
import it.unige.fdt.scriptablesensor.services.FeatureScheduler;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorLUTFeatureService implements FeatureScheduler<LUTFeature> {

    private static final Logger LOGGER = LoggerFactory.getLogger(SensorLUTFeatureService.class);

    @Inject
    SensorLUTFeatureComponentService sensorLUTFeatureComponentService;

    @Override
    public void scheduleFeature(String featureName, LUTFeature lutFeature) {
	for (LUTFeatureComponent featureComponent : lutFeature.getFeatureComponents()) {
	    sensorLUTFeatureComponentService.scheduleFeatureComponent(featureName, lutFeature, featureComponent);
	}
	LOGGER.debug("Scheduled LUT feature {}", featureName);
    }
}
