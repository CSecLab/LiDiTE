package it.unige.fdt.scriptablesensor.utils;

import org.apache.commons.math3.linear.RealMatrix;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.datatype.jdk8.Jdk8Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.module.paramnames.ParameterNamesModule;

import it.unige.fdt.scriptablesensor.deserializers.RealMatrixDeserializer;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Singleton;

@ApplicationScoped
public class ObjectMapperFactory {

    @Produces
    @Singleton
    public ObjectMapper getObjectMapper() {
	// Register our components
	SimpleModule module = new SimpleModule();
	module.addDeserializer(RealMatrix.class, new RealMatrixDeserializer());
	// Build the mapper
	return new ObjectMapper().registerModule(module).registerModule(new ParameterNamesModule())
		.registerModule(new Jdk8Module()).registerModule(new JavaTimeModule());
    }
}
