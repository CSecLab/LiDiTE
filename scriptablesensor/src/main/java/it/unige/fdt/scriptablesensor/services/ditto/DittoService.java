package it.unige.fdt.scriptablesensor.services.ditto;

import java.time.Duration;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;

import org.eclipse.ditto.client.DittoClient;
import org.eclipse.ditto.client.DittoClients;
import org.eclipse.ditto.client.configuration.BasicAuthenticationConfiguration;
import org.eclipse.ditto.client.configuration.MessagingConfiguration;
import org.eclipse.ditto.client.configuration.WebSocketMessagingConfiguration;
import org.eclipse.ditto.client.live.LiveThingHandle;
import org.eclipse.ditto.client.messaging.AuthenticationProvider;
import org.eclipse.ditto.client.messaging.AuthenticationProviders;
import org.eclipse.ditto.client.messaging.MessagingProvider;
import org.eclipse.ditto.client.messaging.MessagingProviders;
import org.eclipse.ditto.client.twin.TwinThingHandle;
import org.eclipse.ditto.model.base.json.JsonSchemaVersion;
import org.eclipse.ditto.model.things.ThingId;
import org.eclipse.microprofile.config.Config;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.neovisionaries.ws.client.WebSocket;

import it.unige.fdt.scriptablesensor.model.Sensor;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.context.Dependent;
import jakarta.enterprise.inject.Disposes;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Inject;
import jakarta.inject.Singleton;

@ApplicationScoped
public class DittoService {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(DittoService.class);

    @Inject
    Config config;

    @Inject
    ExecutorService executorService;

    @Singleton
    @Produces
    public MessagingProvider getMessagingProvider() {
	MessagingConfiguration msgConfig = WebSocketMessagingConfiguration.newBuilder()
		.endpoint(config.getConfigValue("fdt.ditto.url").getValue())
		// Use v2
		.jsonSchemaVersion(JsonSchemaVersion.V_2)
		// Error handler
		.connectionErrorHandler(err -> LOGGER.error("Failed connection to Ditto", err))
		// Enable retries
		.initialConnectRetryEnabled(true).reconnectEnabled(true).timeout(Duration.ofSeconds(30L)).build();
	AuthenticationProvider<WebSocket> authenticationProvider = AuthenticationProviders
		.basic(BasicAuthenticationConfiguration.newBuilder()
			.username(config.getConfigValue("fdt.ditto.username").getValue())
			.password(config.getConfigValue("fdt.ditto.password").getValue()).build());

	return MessagingProviders.webSocket(msgConfig, authenticationProvider, executorService);
    }

    @Singleton
    @Produces
    public DittoClient getDittoClient(MessagingProvider messagingProvider) {
	return DittoClients.newInstance(messagingProvider);
    }

    @Produces
    @Dependent
    public TwinThingHandle getDittoTwinHandle(DittoClient client, Sensor sensor) {
	return client.twin().forId(ThingId.of(sensor.getName()));
    }

    @Produces
    @Dependent
    public LiveThingHandle getDittoLiveHandle(DittoClient client, Sensor sensor)
	    throws InterruptedException, ExecutionException {
	client.live().startConsumption().get();
	return client.live().forId(ThingId.of(sensor.getName()));
    }

    public void closeDittoClient(@Disposes DittoClient client) {
	client.destroy();
    }
}
