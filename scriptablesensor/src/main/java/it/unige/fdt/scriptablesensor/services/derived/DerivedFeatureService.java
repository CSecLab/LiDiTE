package it.unige.fdt.scriptablesensor.services.derived;

import it.unige.fdt.scriptablesensor.model.feature.derived.DerivedFeature;
import it.unige.fdt.scriptablesensor.services.FeatureScheduler;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class DerivedFeatureService implements FeatureScheduler<DerivedFeature> {
    
    @Inject
    DerivedFeatureComponentService derivedFeatureComponentService;

    @Override
    public void scheduleFeature(String featureName, DerivedFeature feature) {
	feature.getComponents().forEach(c -> derivedFeatureComponentService.scheduleFeatureComponent(featureName, feature, c));
    }

}
