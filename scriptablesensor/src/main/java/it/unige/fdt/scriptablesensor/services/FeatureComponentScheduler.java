package it.unige.fdt.scriptablesensor.services;

import it.unige.fdt.scriptablesensor.model.feature.Feature;
import it.unige.fdt.scriptablesensor.model.feature.FeatureComponent;

public interface FeatureComponentScheduler<A extends Feature, B extends FeatureComponent<A>> {
    public void scheduleFeatureComponent(String featureName, A feature, B component);
}
