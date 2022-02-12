package it.unige.fdt.scriptablesensor.model.feature.lut.values;

import java.util.TreeSet;

import org.apache.commons.math3.analysis.UnivariateFunction;
import org.apache.commons.math3.analysis.interpolation.LinearInterpolator;
import org.apache.commons.math3.analysis.interpolation.UnivariateInterpolator;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import it.unige.fdt.scriptablesensor.deserializers.TimeValuePairLUTDeserializer;

@JsonDeserialize(using = TimeValuePairLUTDeserializer.class)
public class TimeValuePairLUT<T extends TimeValuePair> extends TreeSet<T> {

	private static final long serialVersionUID = -7951751738031030982L;

	private UnivariateFunction getSingletonFunction() {
		return x -> this.first().getValue();
	}
	
	private UnivariateFunction getLinearInterpolatingFunction() {
		// Initialize the arrays
		double[] x = new double[this.size()];
		double[] y = new double[this.size()];
		// Build the x-y arrays
		int i = 0;
		for (TimeValuePair timePair : this) {
			x[i] = (double) timePair.getMinuteInDay();
		    y[i] = timePair.getValue();
		    i++;
		}
		// Return the interpolating function
		UnivariateInterpolator interpolator = new LinearInterpolator();
		return interpolator.interpolate(x, y);
	}

	public UnivariateFunction getInterpolatingFunction() {
		if (this.isEmpty()) {
			throw new RuntimeException("No points available");
		} else if (this.size() == 1) {
			return getSingletonFunction();
		} else {
			return getLinearInterpolatingFunction();
		}
    }

}
