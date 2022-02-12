package it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator;

import org.apache.commons.math3.ode.FirstOrderIntegrator;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;
import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;

import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.fixed.SystemSimulatorLutherIntegratorSettings;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.fixed.SystemSimulatorMidpointIntegratorSettings;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.fixed.SystemSimulatorRungeKuttaIntegratorSettings;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.variable.SystemSimulatorGraggBulirschStoerIntegratorSettings;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.integrator.variable.SystemSimulatorHighamHall54IntegratorSettings;

@JsonTypeInfo(use = Id.NAME, include = As.EXISTING_PROPERTY, property = "type")
@JsonSubTypes({
	// Fixed
	@JsonSubTypes.Type(name = "Midpoint", value = SystemSimulatorMidpointIntegratorSettings.class),
	@JsonSubTypes.Type(name = "RungeKutta", value = SystemSimulatorRungeKuttaIntegratorSettings.class),
	@JsonSubTypes.Type(name = "Luther", value = SystemSimulatorLutherIntegratorSettings.class),
	// Variable
	@JsonSubTypes.Type(name = "GraggBulirschStoer", value = SystemSimulatorGraggBulirschStoerIntegratorSettings.class),
	@JsonSubTypes.Type(name = "HighamHall54", value = SystemSimulatorHighamHall54IntegratorSettings.class) })
public abstract class SystemSimulatorIntegratorSettings {

    protected final double checkTolerance;

    protected final double checkMaxTimeBetween;

    protected final int checkMaxIterations;

    protected SystemSimulatorIntegratorSettings(double checkTolerance, double checkMaxTimeBetween,
	    int checkMaxIterations) {
	this.checkTolerance = checkTolerance;
	this.checkMaxTimeBetween = checkMaxTimeBetween;
	this.checkMaxIterations = checkMaxIterations;
    }

    public double getCheckTolerance() {
	return checkTolerance;
    }

    public double getCheckMaxTimeBetween() {
	return checkMaxTimeBetween;
    }

    public int getCheckMaxIterations() {
	return checkMaxIterations;
    }

    public abstract FirstOrderIntegrator buildIntegrator();

    @Override
    public String toString() {
	return "SystemSimulatorIntegratorSettings [checkTolerance=" + checkTolerance + ", checkMaxTimeBetween="
		+ checkMaxTimeBetween + ", checkMaxIterations=" + checkMaxIterations + "]";
    }

}
