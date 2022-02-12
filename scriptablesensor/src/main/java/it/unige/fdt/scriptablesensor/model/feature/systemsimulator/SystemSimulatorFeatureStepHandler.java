package it.unige.fdt.scriptablesensor.model.feature.systemsimulator;

import java.util.Optional;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class SystemSimulatorFeatureStepHandler {

    private final String functionName;
    private final Optional<Double> fixedStep;

    @JsonCreator
    public SystemSimulatorFeatureStepHandler(@JsonProperty(value = "functionName", required = true) String functionName,
	    @JsonProperty(value = "every") Optional<Double> fixedRate) {
	this.functionName = functionName;
	this.fixedStep = fixedRate;
    }

    public String getFunctionName() {
	return functionName;
    }

    public Optional<Double> getFixedStep() {
	return fixedStep;
    }

}
