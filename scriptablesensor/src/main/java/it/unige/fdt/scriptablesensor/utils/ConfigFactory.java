package it.unige.fdt.scriptablesensor.utils;

import org.eclipse.microprofile.config.Config;

import io.smallrye.config.SmallRyeConfigBuilder;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Singleton;

@ApplicationScoped
public class ConfigFactory {

    @Produces
    @Singleton
    public Config getConfig() {
	return new SmallRyeConfigBuilder().addDefaultSources().build();
    }
}
