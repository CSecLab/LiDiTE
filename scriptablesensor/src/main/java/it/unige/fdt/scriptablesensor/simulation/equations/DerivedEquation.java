package it.unige.fdt.scriptablesensor.simulation.equations;

import org.apache.commons.math3.linear.ArrayRealVector;
import org.apache.commons.math3.linear.RealMatrix;
import org.apache.commons.math3.linear.RealVector;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class DerivedEquation {

    private final RealMatrix c;
    private final RealMatrix d;

    @JsonCreator
    public DerivedEquation(@JsonProperty("C") RealMatrix c, @JsonProperty("D") RealMatrix d) {
	this.c = c;
	this.d = d;
    }

    public RealMatrix getC() {
	return c;
    }

    public RealMatrix getD() {
	return d;
    }

    public double calculateValue(RealVector state, RealVector input) {
	RealVector cResult = c.operate(state);
	RealVector dResult = d.operate(input);
	RealVector output = cResult.add(dResult);
	return output.getEntry(0);
    }

    public double calculateValue(double[] state, double[] input) {
	return calculateValue(new ArrayRealVector(state), new ArrayRealVector(input));
    }

    @Override
    public String toString() {
	return "DerivedEquation [c=" + c + ", d=" + d + "]";
    }

}
