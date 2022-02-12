package it.unige.fdt.scriptablesensor.model.feature.lut;

import java.util.Collections;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.Feature;

public class LUTFeature implements Feature {

    private final double updateFrequency;
    private final List<LUTFeatureComponent> featureComponents;
    private final List<String> updateCallbacks;

    @JsonCreator
    public LUTFeature(@JsonProperty(value = "updateFrequency", required = true) double updateFrequency,
	    @JsonProperty(value = "components", required = true) List<LUTFeatureComponent> featureComponents,
	    @JsonProperty("updateCallbacks") List<String> updateCallbacks) {
	this.updateFrequency = updateFrequency;
	this.featureComponents = featureComponents;
	this.updateCallbacks = Objects.requireNonNullElseGet(updateCallbacks, Collections::emptyList);
    }

    public double getUpdateFrequency() {
	return updateFrequency;
    }

    public List<LUTFeatureComponent> getFeatureComponents() {
	return featureComponents;
    }

    public List<String> getUpdateCallbacks() {
	return updateCallbacks;
    }

    @Override
    public String toString() {
	return "LUTFeature [updateFrequency=" + updateFrequency + ", featureComponents=" + featureComponents + "]";
    }

}
