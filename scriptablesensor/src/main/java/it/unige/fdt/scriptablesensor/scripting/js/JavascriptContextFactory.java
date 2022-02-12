package it.unige.fdt.scriptablesensor.scripting.js;

import org.graalvm.polyglot.Context;
import org.graalvm.polyglot.Engine;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Disposes;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Named;
import jakarta.inject.Singleton;

@ApplicationScoped
public class JavascriptContextFactory {

    private JavascriptContextFactory() {
    }

    public static final String LANGUAGE_NAME = "js";

    @Produces
    @Named("javascriptContext")
    @Singleton
    public static Context getJavascriptContext(Engine engine) {
	return Context.newBuilder(LANGUAGE_NAME)
		// Allow to perform all sorts of operations - TODO
		.allowAllAccess(true)
		// Use the shared engine
		.engine(engine)
		// Set options
		.option("js.strict", "true")
		// Build
		.build();
    }

    public static void disposeOfJSContext(@Disposes @Named("javascriptContext") Context context) {
	context.close();
    }
}
