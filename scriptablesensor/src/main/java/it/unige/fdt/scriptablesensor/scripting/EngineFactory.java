package it.unige.fdt.scriptablesensor.scripting;

import org.graalvm.options.OptionDescriptor;
import org.graalvm.polyglot.Engine;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Singleton;

@ApplicationScoped
public class EngineFactory {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(EngineFactory.class);
    
    private static void printOptionDescriptor(OptionDescriptor optionDescriptor) {
	String logMsg = optionDescriptor.getName() + ": " + optionDescriptor.getHelp() + " (" + optionDescriptor.getStability() + ")";
	LOGGER.debug(logMsg);
    }
    
    @Produces
    @Singleton
    public Engine getEngineInstance() {
	Engine engine = Engine.newBuilder()
		.build();
	if (LOGGER.isDebugEnabled()) {
	    engine.getOptions().forEach(EngineFactory::printOptionDescriptor);
	    engine.getLanguages().forEach((languageName, language) -> {
		language.getOptions().forEach(EngineFactory::printOptionDescriptor);
	    });
	}
	return engine;
    }
}
