package it.unige.fdt.scriptablesensor.simulation.stephandlers;

import java.util.function.Consumer;

import org.apache.commons.math3.exception.MaxCountExceededException;
import org.apache.commons.math3.ode.sampling.StepHandler;
import org.apache.commons.math3.ode.sampling.StepInterpolator;

public class EndTimeStepHandler implements StepHandler {

    private final Consumer<Double> endTimeConsumer;

    public EndTimeStepHandler(Consumer<Double> endTimeConsumer) {
	this.endTimeConsumer = endTimeConsumer;
    }

    @Override
    public void init(double t0, double[] y0, double t) {

    }

    @Override
    public void handleStep(StepInterpolator interpolator, boolean isLast) throws MaxCountExceededException {
	if (isLast) {
	    endTimeConsumer.accept(interpolator.getCurrentTime());
	}
    }
}
