package it.unige.fdt.scriptablesensor.services.javascript;

import it.unige.fdt.scriptablesensor.model.feature.javascript.JavascriptFeature;
import it.unige.fdt.scriptablesensor.model.feature.javascript.JavascriptFeatureComponent;
import it.unige.fdt.scriptablesensor.services.FeatureScheduler;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class JavascriptFeatureService implements FeatureScheduler<JavascriptFeature> {
    
    @Inject
    JavascriptFeatureComponentService featureComponentService;
    
    @Override
    public void scheduleFeature(String featureName, JavascriptFeature feature) {
	for (JavascriptFeatureComponent component : feature.getFeatureComponents()) {
	    featureComponentService.scheduleFeatureComponent(featureName, feature, component);
	}
    }

}
