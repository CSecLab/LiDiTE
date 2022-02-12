package it.unige.fdt.scriptablesensor.simulation.eventhandlers;

import java.util.Arrays;
import java.util.stream.Collectors;

public class EventData {

    private final double t;
    private final double[] y;
    private final boolean increasing;

    public EventData(double t, double[] y, boolean increasing) {
	this.t = t;
	this.y = y;
	this.increasing = increasing;
    }

    public double getT() {
	return t;
    }

    public double[] getY() {
	return y;
    }

    public boolean isIncreasing() {
	return increasing;
    }

    @Override
    public String toString() {
	return "t = " + t + ", state = " + Arrays.stream(y).mapToObj(Double::toString).collect(Collectors.joining(", "))
		+ ", increasing = " + increasing;
    }
}
