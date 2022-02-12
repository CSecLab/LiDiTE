package it.unige.fdt.scriptablesensor.model.feature.systemsimulator;

import java.util.Map;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.simulation.equations.DerivedEquation;

public class SystemSimulatorFeatureMappings {

    private final Map<String, Integer> stateVariableMappings;

    private final Map<String, DerivedEquation> fromStateMappings;

    private final Map<String, String> fromJavaScriptMappings;

    @JsonCreator
    public SystemSimulatorFeatureMappings(
	    @JsonProperty(value = "state", required = true) Map<String, Integer> stateVariableMappings,
	    @JsonProperty(value = "fromState", required = true) Map<String, DerivedEquation> fromStateMappings,
	    @JsonProperty(value = "fromJavaScript", required = true) Map<String, String> fromJavaScriptMappings) {
	this.stateVariableMappings = stateVariableMappings;
	this.fromStateMappings = fromStateMappings;
	this.fromJavaScriptMappings = fromJavaScriptMappings;
    }

    public Map<String, Integer> getStateVariableMappings() {
	return stateVariableMappings;
    }

    public Map<String, DerivedEquation> getFromStateMappings() {
	return fromStateMappings;
    }

    public Map<String, String> getFromJavaScriptMappings() {
	return fromJavaScriptMappings;
    }

    @Override
    public String toString() {
	return "SystemSimulatorFeatureMappings [stateVariableMappings=" + stateVariableMappings + ", fromStateMappings="
		+ fromStateMappings + ", fromJavaScriptMappings=" + fromJavaScriptMappings + "]";
    }
}
