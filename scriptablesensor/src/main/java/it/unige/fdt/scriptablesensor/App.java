package it.unige.fdt.scriptablesensor;

import java.util.List;

import org.jboss.weld.environment.se.bindings.Parameters;
import org.jboss.weld.environment.se.events.ContainerInitialized;

import it.unige.fdt.scriptablesensor.services.SensorService;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Singleton;

@Singleton
public class App {

    private App() {
    }

    public static void main(@Observes ContainerInitialized event, @Parameters List<String> parameters,
	    SensorService sensorService) throws Exception {
	sensorService.startSimulation();
    }
}
