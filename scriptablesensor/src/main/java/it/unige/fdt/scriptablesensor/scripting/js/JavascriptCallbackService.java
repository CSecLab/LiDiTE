package it.unige.fdt.scriptablesensor.scripting.js;

import java.util.Arrays;
import java.util.stream.Collectors;

import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.Source;
import org.graalvm.polyglot.Value;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.scripting.js.restutil.JavascriptRESTUtil;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.inject.Named;

@ApplicationScoped
public class JavascriptCallbackService {

    private static final Logger LOGGER = LoggerFactory.getLogger(JavascriptCallbackService.class);

    @Inject
    @Named("javascriptContext")
    Context context;

    @Inject
    @Named("javascriptSource")
    Source source;
    
    @Inject
    JavascriptRESTUtil restUtil;

    Value jsObject;

    @PostConstruct
    void parseJsObject() {
	this.jsObject = context.eval(source);
	LOGGER.debug("Loaded Javascript source file");
	// Perform bindings
	bindObject("RESTUtil", restUtil);
    }

    public <T> void bindObject(String name, T object) {
	context.getBindings(JavascriptContextFactory.LANGUAGE_NAME).putMember(name, object);
	LOGGER.debug("Ensured JS binding for {}", name);
    }

    private synchronized boolean functionExists(String functionName) {
	Value member = jsObject.getMember(functionName);
	return member != null && member.canExecute();
    }

    private void ensureFunctionExists(String functionName) {
	if (!functionExists(functionName)) {
	    throw new IllegalArgumentException(functionName + " is not a valid function");
	}
    }

    private static void logJSCall(String functionName, Object... input) {
	if (LOGGER.isDebugEnabled()) {
	    LOGGER.debug("Calling JS function {}({})", functionName,
		    Arrays.stream(input).map(o -> o.getClass().getSimpleName()).collect(Collectors.joining(", ")));
	}
    }

    public synchronized void callFunction(String functionName, Object... input) {
	ensureFunctionExists(functionName);
	logJSCall(functionName, input);
	jsObject.invokeMember(functionName, input);
    }

    public synchronized <I, O> O callFunction(String functionName, I input, Class<O> outputClass) {
	return callFunction(functionName, outputClass, input);
    }

    public synchronized <O> O callFunction(String functionName, Class<O> outputClass, Object... input) {
	ensureFunctionExists(functionName);
	logJSCall(functionName, input);
	O result = jsObject.invokeMember(functionName, input).as(outputClass);
	LOGGER.debug("JS function result: {}", result);
	return result;
    }
}
