package it.unige.fdt.scriptablesensor.services;

import org.jboss.weld.exceptions.UnsupportedOperationException;

import it.unige.fdt.scriptablesensor.model.feature.Feature;
import it.unige.fdt.scriptablesensor.model.feature.derived.DerivedFeature;
import it.unige.fdt.scriptablesensor.model.feature.javascript.JavascriptFeature;
import it.unige.fdt.scriptablesensor.model.feature.lut.LUTFeature;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.SystemSimulatorFeature;
import it.unige.fdt.scriptablesensor.services.derived.DerivedFeatureService;
import it.unige.fdt.scriptablesensor.services.javascript.JavascriptFeatureService;
import it.unige.fdt.scriptablesensor.services.lut.SensorLUTFeatureService;
import it.unige.fdt.scriptablesensor.services.simulation.SensorSystemSimulatorFeatureService;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class SensorFeatureService {
    
    @Inject
    DerivedFeatureService derivedFeatureService;

    @Inject
    SensorLUTFeatureService sensorLUTFeatureService;

    @Inject
    SensorSystemSimulatorFeatureService sensorSystemSimulatorFeatureService;
    
    @Inject
    JavascriptFeatureService javascriptFeatureService;

    public void scheduleFeature(String featureName, Feature feature) {
	if (feature instanceof DerivedFeature) {
	    DerivedFeature derivedFeature = (DerivedFeature) feature;
	    derivedFeatureService.scheduleFeature(featureName, derivedFeature);
	} else if (feature instanceof LUTFeature) {
	    LUTFeature lutFeature = (LUTFeature) feature;
	    sensorLUTFeatureService.scheduleFeature(featureName, lutFeature);
	} else if (feature instanceof SystemSimulatorFeature) {
	    SystemSimulatorFeature systemSimulatorFeature = (SystemSimulatorFeature) feature;
	    sensorSystemSimulatorFeatureService.scheduleFeature(featureName, systemSimulatorFeature);
	} else if (feature instanceof JavascriptFeature) {
	    JavascriptFeature javascriptFeature = (JavascriptFeature) feature;
	    javascriptFeatureService.scheduleFeature(featureName, javascriptFeature);
	} else {
	    throw new UnsupportedOperationException("Unknown feature kind");
	}
    }
}
