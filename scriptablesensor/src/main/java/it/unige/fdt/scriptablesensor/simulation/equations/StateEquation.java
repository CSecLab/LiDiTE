package it.unige.fdt.scriptablesensor.simulation.equations;

import org.apache.commons.math3.exception.DimensionMismatchException;
import org.apache.commons.math3.exception.MaxCountExceededException;
import org.apache.commons.math3.linear.ArrayRealVector;
import org.apache.commons.math3.linear.RealMatrix;
import org.apache.commons.math3.linear.RealVector;
import org.apache.commons.math3.ode.FirstOrderDifferentialEquations;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class StateEquation implements FirstOrderDifferentialEquations {

    protected final RealMatrix a;

    protected final RealMatrix b;

    protected final RealVector u;

    public StateEquation(RealMatrix a, RealMatrix b, RealVector u0) {
	this.a = a;
	this.b = b;
	this.u = u0;
    }

    @JsonCreator
    public StateEquation(@JsonProperty("A") RealMatrix a, @JsonProperty("B") RealMatrix b) {
	this(a, b, new ArrayRealVector(b.getColumnDimension()));
    }

    public RealMatrix getA() {
	return a;
    }

    public RealMatrix getB() {
	return b;
    }

    public RealVector getU() {
	return u;
    }

    @Override
    public int getDimension() {
	return a.getRowDimension();
    }

    @Override
    public void computeDerivatives(double t, double[] y, double[] yDot)
	    throws MaxCountExceededException, DimensionMismatchException {
	RealVector oldStateVector = new ArrayRealVector(y);
	// Ax
	RealVector aResult = a.operate(oldStateVector);
	// Bu
	RealVector bResult = b.operate(u);
	// Calculate xDot as Ax + Bu
	RealVector xDotVector = aResult.add(bResult);
	// Apply the new xDot
	for (int i = 0; i < yDot.length; i++) {
	    yDot[i] = xDotVector.getEntry(i);
	}
    }

    @Override
    public String toString() {
	return "StateEquation [a=" + a + ", b=" + b + ", u=" + u + "]";
    }
}
