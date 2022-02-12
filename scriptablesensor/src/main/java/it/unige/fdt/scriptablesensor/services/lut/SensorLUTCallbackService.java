package it.unige.fdt.scriptablesensor.services.lut;

import java.util.List;
import java.util.stream.Collectors;

import it.unige.fdt.scriptablesensor.model.Sensor;
import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import it.unige.fdt.scriptablesensor.model.feature.lut.LUTFeature;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptCallbackService;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorLUTCallbackService {

    @Inject
    JavascriptCallbackService jsCallbackService;

    @Inject
    Sensor sensor;

    private List<LUTFeature> lutFeatures;

    @PostConstruct
    void grabLUTFeatures() {
	lutFeatures = sensor.getFeatures().values().parallelStream().filter(f -> f instanceof LUTFeature)
		.map(LUTFeature.class::cast).collect(Collectors.toUnmodifiableList());
    }

    private void dispatchUpdate(String functionName, SensorFeatureUpdateMessage<?> update) {
	jsCallbackService.callFunction(functionName, update.getFeatureName(), update.getPropertyName(),
		update.getPayload());
    }

    private void dispatchUpdateToFeature(LUTFeature lutFeature, SensorFeatureUpdateMessage<?> update) {
	for (String functionName : lutFeature.getUpdateCallbacks()) {
	    dispatchUpdate(functionName, update);
	}
    }

    void observeChange(@Observes SensorFeatureUpdateMessage<?> update) {
	for (LUTFeature lutFeature : lutFeatures) {
	    dispatchUpdateToFeature(lutFeature, update);
	}
    }
}
