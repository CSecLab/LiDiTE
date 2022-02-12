package it.unige.fdt.scriptablesensor.model;

import java.io.IOException;
import java.nio.file.Path;

import org.eclipse.microprofile.config.Config;

import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Inject;
import jakarta.inject.Named;
import jakarta.inject.Singleton;

@ApplicationScoped
public class SensorFactory {

    @Inject
    Config config;

    @Produces
    @Named("sensorFilePath")
    public Path getSensorFilePath() {
	return Path.of(config.getOptionalValue("fdt.sensor.json", String.class).orElse("sensor.json"));
    }

    @Singleton
    @Produces
    public Sensor parseSensor(ObjectMapper objectMapper, @Named("sensorFilePath") Path sensorPath) throws IOException {
	return objectMapper.readValue(sensorPath.toFile(), Sensor.class);
    }

}
