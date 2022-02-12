package it.unige.fdt.scriptablesensor.model.feature.derived;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.Feature;

public class DerivedFeature implements Feature {
    
    private final double updateFrequency;
    private final List<DerivedFeatureComponent> components;

    @JsonCreator
    public DerivedFeature(@JsonProperty(value = "updateFrequency", required = true) double updateFrequency, @JsonProperty(value = "components", required = true) List<DerivedFeatureComponent> components) {
	this.updateFrequency = updateFrequency;
	this.components = components;
    }

    public double getUpdateFrequency() {
        return updateFrequency;
    }

    public List<DerivedFeatureComponent> getComponents() {
        return components;
    }

    @Override
    public String toString() {
	return "DerivedFeature [updateFrequency=" + updateFrequency + ", components=" + components + "]";
    }
    
}
