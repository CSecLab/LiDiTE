package it.unige.fdt.scriptablesensor.scripting.js;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.eclipse.microprofile.config.Config;
import org.graalvm.polyglot.Source;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Inject;
import jakarta.inject.Named;

@ApplicationScoped
public class JavascriptSourceFactory {

    @Inject
    Config config;

    @Produces
    @Named("javascriptSource")
    public Source getJavascriptSource() throws IOException {
	String jsSource = Files
		.readString(Path.of(config.getOptionalValue("fdt.sensor.js", String.class).orElse("sensor.js")));
	return Source.create(JavascriptContextFactory.LANGUAGE_NAME, jsSource);
    }

}
