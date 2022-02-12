package it.unige.fdt.scriptablesensor.model.feature.javascript;

import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.FeatureComponent;

public class JavascriptFeatureComponent implements FeatureComponent<JavascriptFeature> {
    
    private final String name;
    private final String functionName;
    
    public JavascriptFeatureComponent(@JsonProperty(value = "name", required = true) String name, @JsonProperty(value = "functionName", required = true) String functionName) {
	this.name = name;
	this.functionName = functionName;
    }

    public String getName() {
        return name;
    }

    public String getFunctionName() {
        return functionName;
    }

    @Override
    public String toString() {
	return "JavascriptFeatureComponent [name=" + name + ", functionName=" + functionName + "]";
    }
    
}
