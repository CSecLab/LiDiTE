package it.unige.fdt.scriptablesensor.model.feature.systemsimulator;

import java.util.Collections;
import java.util.List;
import java.util.Objects;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class SystemSimulatorFeatureEventHandlers {

    private final List<SystemSimulatorFeatureGStopHandler> gStopHandlers;

    @JsonCreator
    public SystemSimulatorFeatureEventHandlers(
	    @JsonProperty(value = "g-stop") List<SystemSimulatorFeatureGStopHandler> gStopHandlers) {
	this.gStopHandlers = Objects.requireNonNullElseGet(gStopHandlers, Collections::emptyList);
    }

    public List<SystemSimulatorFeatureGStopHandler> getgStopHandlers() {
	return gStopHandlers;
    }

    @Override
    public String toString() {
	return "SystemSimulatorFeatureEventHandlers [gStopHandlers=" + gStopHandlers + "]";
    }

}
