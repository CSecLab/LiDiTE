package it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.variable;

import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.SystemSimulatorIntegratorSettings;

public abstract class SystemSimulatorVariableStepIntegratorSettings extends SystemSimulatorIntegratorSettings {

    protected final double minStepSize;
    protected final double maxStepSize;
    protected final double relativeTolerance;
    protected final double absoluteTolerance;

    protected SystemSimulatorVariableStepIntegratorSettings(double minStepSize, double maxStepSize,
	    double relativeTolerance, double absoluteTolerance, double checkTolerance, double checkMaxTimeBetween,
	    int checkMaxIterations) {
	super(checkTolerance, checkMaxTimeBetween, checkMaxIterations);
	this.minStepSize = minStepSize;
	this.maxStepSize = maxStepSize;
	this.relativeTolerance = relativeTolerance;
	this.absoluteTolerance = absoluteTolerance;
    }

    public double getMinStepSize() {
	return minStepSize;
    }

    public double getMaxStepSize() {
	return maxStepSize;
    }

    public double getRelativeTolerance() {
	return relativeTolerance;
    }

    public double getAbsoluteTolerance() {
	return absoluteTolerance;
    }

}
