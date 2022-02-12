package it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.fixed;

import org.apache.commons.math3.ode.FirstOrderIntegrator;
import org.apache.commons.math3.ode.nonstiff.ClassicalRungeKuttaIntegrator;

import com.fasterxml.jackson.annotation.JsonProperty;

public class SystemSimulatorRungeKuttaIntegratorSettings extends SystemSimulatorFixedStepIntegratorSettings {

    public SystemSimulatorRungeKuttaIntegratorSettings(@JsonProperty("stepSize") double stepSize,
	    @JsonProperty("checkTolerance") double checkTolerance,
	    @JsonProperty("checkMaxTimeBetween") double checkMaxTimeBetween,
	    @JsonProperty("checkMaxIterations") int checkMaxIterations) {
	super(stepSize, checkTolerance, checkMaxTimeBetween, checkMaxIterations);
    }

    @Override
    public FirstOrderIntegrator buildIntegrator() {
	return new ClassicalRungeKuttaIntegrator(stepSize);
    }

}
