package it.unige.fdt.scriptablesensor.model;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class SensorMessageCallbackSpecification {

    private final String functionName;
    private final String topic;

    @JsonCreator
    public SensorMessageCallbackSpecification(@JsonProperty("functionName") String functionName,
	    @JsonProperty("topic") String topic) {
	this.functionName = functionName;
	this.topic = topic;
    }

    public String getFunctionName() {
	return functionName;
    }

    public String getTopic() {
	return topic;
    }

    @Override
    public String toString() {
	return "SensorMessageCallbackSpecification [functionName=" + functionName + ", topic=" + topic + "]";
    }

}
