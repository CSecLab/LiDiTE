package it.unige.fdt.scriptablesensor.services;

import it.unige.fdt.scriptablesensor.model.feature.Feature;

public interface FeatureScheduler<T extends Feature> {
    void scheduleFeature(String featureName, T feature);
}
