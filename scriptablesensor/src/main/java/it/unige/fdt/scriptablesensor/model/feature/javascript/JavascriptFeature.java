package it.unige.fdt.scriptablesensor.model.feature.javascript;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.Feature;

public class JavascriptFeature implements Feature {

    private final double updateFrequency;
    private final List<JavascriptFeatureComponent> featureComponents;
    
    @JsonCreator
    public JavascriptFeature(@JsonProperty(value = "updateFrequency", required = true) double updateFrequency, @JsonProperty(value = "components", required = true) List<JavascriptFeatureComponent> featureComponents) {
	this.updateFrequency = updateFrequency;
	this.featureComponents = featureComponents;
    }

    public double getUpdateFrequency() {
        return updateFrequency;
    }

    public List<JavascriptFeatureComponent> getFeatureComponents() {
        return featureComponents;
    }

    @Override
    public String toString() {
	return "JavascriptFeature [updateFrequency=" + updateFrequency + ", featureComponents=" + featureComponents
		+ "]";
    }

}
