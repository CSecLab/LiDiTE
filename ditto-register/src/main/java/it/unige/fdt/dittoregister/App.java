package it.unige.fdt.dittoregister;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.json.JsonMapper;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;

import it.unige.fdt.dittoregister.ditto.DittoSender;

public class App 
{
    public static final ObjectMapper objectMapper = JsonMapper.builder()
	    // Modules
	    .addModule(new ParameterNamesModule())
	    .addModule(new Jdk8Module())
	    .addModule(new JavaTimeModule())
	    // Build
	    .build();
    
    public static void main(String[] args) throws JsonParseException, JsonMappingException, IOException
    {
    	// Start by searching definitions directory
        Path definitionsSearchPath = Path.of(Config.getConfig("it.unige.fdt.definitions.path", "ditto-data"));
        System.out.println("Definitions search path is set to " + definitionsSearchPath);
        File definitionsSearchFile = definitionsSearchPath.toFile();
        if (!definitionsSearchFile.isDirectory()) {
        	throw new RuntimeException("Definition search path is not a directory");
        }
        // Register everything
        PoliciesRegistrator policiesRegistrator = new PoliciesRegistrator(definitionsSearchPath);
        policiesRegistrator.registerDefinitions();
        ThingsRegistrator thingsRegistrator = new ThingsRegistrator(definitionsSearchPath);
        thingsRegistrator.registerDefinitions();
        // Shutdown Ditto client
        DittoSender.getDittoClient().destroy();
        System.out.println("Registrations OK");
    }
}
