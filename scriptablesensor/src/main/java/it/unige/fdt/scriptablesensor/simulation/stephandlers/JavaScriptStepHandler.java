package it.unige.fdt.scriptablesensor.simulation.stephandlers;

import org.apache.commons.math3.exception.MaxCountExceededException;
import org.apache.commons.math3.ode.sampling.FixedStepHandler;
import org.apache.commons.math3.ode.sampling.StepHandler;
import org.apache.commons.math3.ode.sampling.StepInterpolator;

import it.unige.fdt.scriptablesensor.scripting.js.JavascriptCallbackService;

public class JavaScriptStepHandler implements StepHandler, FixedStepHandler {

    private final String functionName;
    private final JavascriptCallbackService jsCallbackService;

    public JavaScriptStepHandler(String functionName, JavascriptCallbackService jsCallbackService) {
	this.functionName = functionName;
	this.jsCallbackService = jsCallbackService;
    }

    private void callJavaScriptCallback(double t, double[] y, double[] yDot, boolean isLast) {
	jsCallbackService.callFunction(functionName, t, y, yDot, isLast);
    }

    @Override
    public void init(double t0, double[] y0, double t) {
    }

    @Override
    public void handleStep(StepInterpolator interpolator, boolean isLast) throws MaxCountExceededException {
	callJavaScriptCallback(interpolator.getInterpolatedTime(), interpolator.getInterpolatedState(),
		interpolator.getInterpolatedDerivatives(), isLast);
    }

    @Override
    public void handleStep(double t, double[] y, double[] yDot, boolean isLast) {
	callJavaScriptCallback(t, y, yDot, isLast);
    }

}
