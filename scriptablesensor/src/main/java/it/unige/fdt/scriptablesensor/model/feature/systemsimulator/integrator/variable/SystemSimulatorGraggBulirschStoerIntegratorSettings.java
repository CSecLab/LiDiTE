package it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.variable;

import org.apache.commons.math3.ode.FirstOrderIntegrator;
import org.apache.commons.math3.ode.nonstiff.GraggBulirschStoerIntegrator;

import com.fasterxml.jackson.annotation.JsonProperty;

public class SystemSimulatorGraggBulirschStoerIntegratorSettings extends SystemSimulatorVariableStepIntegratorSettings {

    public SystemSimulatorGraggBulirschStoerIntegratorSettings(@JsonProperty("minStepSize") double minStepSize,
	    @JsonProperty("maxStepSize") double maxStepSize,
	    @JsonProperty("relativeTolerance") double relativeTolerance,
	    @JsonProperty("absoluteTolerance") double absoluteTolerance,
	    @JsonProperty("checkTolerance") double checkTolerance,
	    @JsonProperty("checkMaxTimeBetween") double checkMaxTimeBetween,
	    @JsonProperty("checkMaxIterations") int checkMaxIterations) {
	super(minStepSize, maxStepSize, relativeTolerance, absoluteTolerance, checkTolerance, checkMaxTimeBetween,
		checkMaxIterations);
    }

    @Override
    public FirstOrderIntegrator buildIntegrator() {
	return new GraggBulirschStoerIntegrator(minStepSize, maxStepSize, absoluteTolerance, relativeTolerance);
    }

}
