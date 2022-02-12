package it.unige.fdt.dittoregister;

import java.nio.file.Files;
import java.nio.file.Path;

import org.eclipse.ditto.client.DittoClient;
import org.eclipse.ditto.client.policies.Policies;
import org.eclipse.ditto.json.JsonObject;

import it.unige.fdt.dittoregister.ditto.DittoSender;

public class PoliciesRegistrator extends AbstractDefinitionsIterator {

	private PoliciesRegistrator(Path basePath, String subPath) {
		super(basePath, subPath);
	}

	public PoliciesRegistrator(Path basePath) {
		this(basePath, "policies");
	}

	@Override
	protected void processDefinition(String namespace, Path definitionPath) {
		DittoClient dittoClient = DittoSender.getDittoClient();
		Policies policiesHandler = dittoClient.policies();
		try {
			String definition = Files.readString(definitionPath);
			JsonObject definitionObject = JsonObject.of(definition);
			policiesHandler.put(definitionObject)
				.whenComplete((pol,err) -> {
					if (pol != null && pol.isPresent()) {
						System.out.println("Created policy " + pol.get().getEntityId().get());
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
