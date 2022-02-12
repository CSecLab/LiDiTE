package it.unige.fdt.dittoregister;

import java.nio.file.Files;
import java.nio.file.Path;

import org.eclipse.ditto.client.DittoClient;
import org.eclipse.ditto.client.twin.Twin;
import org.eclipse.ditto.json.JsonObject;

import it.unige.fdt.dittoregister.ditto.DittoSender;

public class ThingsRegistrator extends AbstractDefinitionsIterator {

	private ThingsRegistrator(Path basePath, String subPath) {
		super(basePath, subPath);
	}

	public ThingsRegistrator(Path basePath) {
		this(basePath, "things");
	}

	@Override
	protected void processDefinition(String namespace, Path definitionPath) {
		DittoClient dittoClient = DittoSender.getDittoClient();
		Twin twinHandler = dittoClient.twin();
		try {
			String definition = Files.readString(definitionPath);
			JsonObject definitionObject = JsonObject.of(definition);
			twinHandler.put(definitionObject)
				.whenComplete((thing,err) -> {
					if (thing != null && thing.isPresent()) {
						System.out.println("Created thing " + thing.get().getEntityId().get());
					}
					if (err != null) {
						err.printStackTrace();
						System.exit(1);
					}
				})
				.get();
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
}
