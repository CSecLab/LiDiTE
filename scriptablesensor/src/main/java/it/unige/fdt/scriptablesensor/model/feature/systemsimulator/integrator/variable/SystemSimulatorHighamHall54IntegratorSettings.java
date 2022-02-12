package it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.variable;

import org.apache.commons.math3.ode.FirstOrderIntegrator;
import org.apache.commons.math3.ode.nonstiff.HighamHall54Integrator;

import com.fasterxml.jackson.annotation.JsonProperty;

public class SystemSimulatorHighamHall54IntegratorSettings extends SystemSimulatorVariableStepIntegratorSettings {

    public SystemSimulatorHighamHall54IntegratorSettings(@JsonProperty("minStepSize") double minStepSize,
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
	return new HighamHall54Integrator(minStepSize, maxStepSize, absoluteTolerance, relativeTolerance);
    }

}
