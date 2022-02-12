package it.unige.fdt.dittoregister.ditto;

import java.util.concurrent.Executors;

import org.eclipse.ditto.client.DittoClient;
import org.eclipse.ditto.client.DittoClients;
import org.eclipse.ditto.client.configuration.BasicAuthenticationConfiguration;
import org.eclipse.ditto.client.configuration.WebSocketMessagingConfiguration;
import org.eclipse.ditto.client.messaging.AuthenticationProviders;
import org.eclipse.ditto.client.messaging.MessagingProvider;
import org.eclipse.ditto.client.messaging.MessagingProviders;
import org.eclipse.ditto.client.twin.Twin;
import org.eclipse.ditto.model.base.json.JsonSchemaVersion;

import it.unige.fdt.dittoregister.Config;

public class DittoSender {

	private static DittoClient dittoClient;

	public static DittoClient getDittoClient() {
		if (dittoClient == null) {
			dittoClient = DittoClients.newInstance(getDittoMessagingProvider());
		}
		return dittoClient;
	}

	public static Twin getDittoTwinHandle() {
		return getDittoClient().twin();
	}

	private static MessagingProvider getDittoMessagingProvider() {
		return MessagingProviders
				.webSocket(
						WebSocketMessagingConfiguration.newBuilder()
								.endpoint(Config.getConfig("it.unige.fdt.ditto.url"))
								.connectionErrorHandler(
										err -> System.err.println("Error while connecting to Ditto " + err))
								.reconnectEnabled(true).jsonSchemaVersion(JsonSchemaVersion.V_2)
								.initialConnectRetryEnabled(true).build(),
						AuthenticationProviders.basic(BasicAuthenticationConfiguration.newBuilder()
								.username(Config.getConfig("it.unige.fdt.ditto.username"))
								.password(Config.getConfig("it.unige.fdt.ditto.password")).build()),
						Executors.newCachedThreadPool());
	}
}
