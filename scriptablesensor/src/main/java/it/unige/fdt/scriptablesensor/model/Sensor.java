package it.unige.fdt.scriptablesensor.model;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.Feature;

public class Sensor {

    private final String name;
    private final Map<String, Feature> features;
    private final List<SensorMessageCallbackSpecification> messageCallbackFunctions;

    @JsonCreator
    public Sensor(@JsonProperty(value = "name", required = true) String name,
	    @JsonProperty(value = "features", required = true) Map<String, Feature> features,
	    @JsonProperty(value = "messageCallbackFunctions") List<SensorMessageCallbackSpecification> messageCallbackFunctions) {
	this.name = name;
	this.features = features;
	this.messageCallbackFunctions = Objects.requireNonNullElseGet(messageCallbackFunctions, Collections::emptyList);
    }

    public String getName() {
	return name;
    }

    public Map<String, Feature> getFeatures() {
	return features;
    }

    public List<SensorMessageCallbackSpecification> getMessageCallbackFunctions() {
	return messageCallbackFunctions;
    }

    @Override
    public String toString() {
	return "Sensor [name=" + name + ", features=" + features + ", messageCallbackFunctions="
		+ messageCallbackFunctions + "]";
    }
}
