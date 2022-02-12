package it.unige.fdt.scriptablesensor.model.feature.systemsimulator;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.Feature;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.SystemSimulatorIntegratorSettings;
import it.unige.fdt.scriptablesensor.simulation.equations.StateEquation;

public class SystemSimulatorFeature implements Feature {

    private final double stateRefreshIntervalSeconds;

    private final SystemSimulatorIntegratorSettings integratorSettings;

    private final StateEquation systemDefinition;

    private final SystemSimulatorFeatureMappings featureMappings;

    private final SystemSimulatorFeatureEventHandlers eventHandlers;

    private final List<String> endHandlers;

    private final List<SystemSimulatorFeatureStepHandler> stepHandlers;

    private final double[] initialState;

    @JsonCreator
    public SystemSimulatorFeature(
	    @JsonProperty(value = "stateRefreshIntervalSeconds", required = true) double stateRefreshIntervalSeconds,
	    @JsonProperty(value = "integrator", required = true) SystemSimulatorIntegratorSettings integratorSettings,
	    @JsonProperty(value = "system", required = true) StateEquation systemDefinition,
	    @JsonProperty("initialState") double[] initialState,
	    @JsonProperty(value = "initialInputs", required = true) double[] initialInputs,
	    @JsonProperty(value = "featureMappings", required = true) SystemSimulatorFeatureMappings featureMappings,
	    @JsonProperty(value = "eventHandlers", required = true) SystemSimulatorFeatureEventHandlers eventHandlers,
	    @JsonProperty(value = "intervalEndHandlers") List<String> endHandlers,
	    @JsonProperty(value = "stepHandlers") List<SystemSimulatorFeatureStepHandler> stepHandlers) {
	this.stateRefreshIntervalSeconds = stateRefreshIntervalSeconds;
	this.integratorSettings = integratorSettings;
	this.systemDefinition = systemDefinition;
	this.featureMappings = featureMappings;
	this.eventHandlers = eventHandlers;
	this.endHandlers = Objects.requireNonNullElseGet(endHandlers, Collections::emptyList);
	this.stepHandlers = Objects.requireNonNullElseGet(stepHandlers, Collections::emptyList);
	this.initialState = initialState;
	// Set u0
	for (int i = 0; i < initialInputs.length; i++) {
	    this.systemDefinition.getU().setEntry(i, initialInputs[i]);
	}
    }

    public double getStateRefreshIntervalSeconds() {
	return stateRefreshIntervalSeconds;
    }

    public SystemSimulatorIntegratorSettings getIntegratorSettings() {
	return integratorSettings;
    }

    public StateEquation getSystemDefinition() {
	return systemDefinition;
    }

    public SystemSimulatorFeatureMappings getFeatureMappings() {
	return featureMappings;
    }

    public SystemSimulatorFeatureEventHandlers getEventHandlers() {
	return eventHandlers;
    }

    public List<String> getEndHandlers() {
	return endHandlers;
    }

    public List<SystemSimulatorFeatureStepHandler> getStepHandlers() {
	return stepHandlers;
    }

    public double[] getInitialState() {
	return initialState;
    }

    @Override
    public String toString() {
	return "SystemSimulatorFeature [stateRefreshIntervalSeconds=" + stateRefreshIntervalSeconds
		+ ", integratorSettings=" + integratorSettings + ", systemDefinition=" + systemDefinition
		+ ", featureMappings=" + featureMappings + ", eventHandlers=" + eventHandlers + ", endHandlers="
		+ endHandlers + ", stepHandlers=" + stepHandlers + ", initialState=" + Arrays.toString(initialState)
		+ "]";
    }

}
