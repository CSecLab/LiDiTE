package it.unige.fdt.scriptablesensor.model.feature.lut.values;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class LUTFeatureComponentValueFromJavascript implements LUTFeatureComponentValue {

    private final String functionName;

    @JsonCreator
    public LUTFeatureComponentValueFromJavascript(@JsonProperty("functionName") String functionName) {
	this.functionName = functionName;
    }

    public String getFunctionName() {
	return functionName;
    }

    @Override
    public String toString() {
	return "LUTFeatureComponentValueFromJavascript [functionName=" + functionName + "]";
    }

}
