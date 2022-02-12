package it.unige.fdt.scriptablesensor.services.lut.value;

import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValue;

public interface SensorLUTComponentValueCalculator<T extends LUTFeatureComponentValue> {
    public void calculateFeature(String featureName, String componentName, T componentValue);
}
