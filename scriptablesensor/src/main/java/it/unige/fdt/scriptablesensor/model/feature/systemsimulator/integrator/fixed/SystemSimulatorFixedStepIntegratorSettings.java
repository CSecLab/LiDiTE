package it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.fixed;

import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.SystemSimulatorIntegratorSettings;

public abstract class SystemSimulatorFixedStepIntegratorSettings extends SystemSimulatorIntegratorSettings {

    protected final double stepSize;

    protected SystemSimulatorFixedStepIntegratorSettings(double stepSize, double checkTolerance,
	    double checkMaxTimeBetween, int checkMaxIterations) {
	super(checkTolerance, checkMaxTimeBetween, checkMaxIterations);
	this.stepSize = stepSize;
    }

    public double getStepSize() {
	return stepSize;
    }

}
