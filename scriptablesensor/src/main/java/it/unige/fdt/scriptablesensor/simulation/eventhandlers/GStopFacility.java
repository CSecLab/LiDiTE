package it.unige.fdt.scriptablesensor.simulation.eventhandlers;

import java.util.function.Function;

public class GStopFacility extends EventHandlerFacility {

    private final int stateComponentIndex;
    private final double threshold;

    public GStopFacility(int stateComponentIndex, double threshold, Function<EventData, Action> eventOccurredHandler) {
	super(eventOccurredHandler);
	this.stateComponentIndex = stateComponentIndex;
	this.threshold = threshold;
    }

    public GStopFacility(int stateComponentIndex, double threshold, Action action) {
	this(stateComponentIndex, threshold, s -> action);
    }

    public GStopFacility(int stateComponentIndex, double threshold) {
	this(stateComponentIndex, threshold, Action.STOP);
    }

    @Override
    public void init(double t0, double[] y0, double t) {
    }

    @Override
    public double g(double t, double[] y) {
	return y[stateComponentIndex] - threshold;
    }

    @Override
    public void resetState(double t, double[] y) {
    }

}
