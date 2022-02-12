package it.unige.fdt.scriptablesensor.model.feature.systemsimulator;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class SystemSimulatorFeatureGStopHandler {
    public static enum Direction {
	INCREASING, DECREASING, ANY
    }

    private final String functionName;

    private final int stateIndex;

    private final double threshold;

    private final Direction direction;

    @JsonCreator
    public SystemSimulatorFeatureGStopHandler(@JsonProperty("functionName") String functionName,
	    @JsonProperty("stateIndex") int stateIndex, @JsonProperty("threshold") double threshold,
	    @JsonProperty("direction") Direction direction) {
	this.functionName = functionName;
	this.stateIndex = stateIndex;
	this.threshold = threshold;
	this.direction = direction;
    }

    public String getFunctionName() {
	return functionName;
    }

    public int getStateIndex() {
	return stateIndex;
    }

    public double getThreshold() {
	return threshold;
    }

    public Direction getDirection() {
	return direction;
    }

    @Override
    public String toString() {
	return "SystemSimulatorFeatureGStopHandler [functionName=" + functionName + ", stateIndex=" + stateIndex
		+ ", threshold=" + threshold + ", direction=" + direction + "]";
    }

}
