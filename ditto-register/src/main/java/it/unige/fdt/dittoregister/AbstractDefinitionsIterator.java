package it.unige.fdt.dittoregister;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

public abstract class AbstractDefinitionsIterator {
	
	protected final Path searchPath;
	
	public AbstractDefinitionsIterator(Path basePath, String subPath) {
		this.searchPath = Path.of(basePath.toString(), subPath);
	}
	
	public void registerDefinitions() {
		// Check if search path exists
		if (!searchPath.toFile().isDirectory()) {
			throw new RuntimeException(searchPath + " is not a directory");
		}
		// Iterate path
		try {
			Files.list(searchPath)
				.filter(p -> p.toFile().isDirectory())
				.forEach(p -> processNamespacedDefinitions(p.getFileName().toString(), p));
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
	
	protected void processNamespacedDefinitions(String namespace, Path basePath) {
		try {
			Files.list(basePath)
				.filter(p -> p.toFile().isFile())
				.filter(p -> p.getFileName().toString().endsWith(".json"))
				.forEach(p -> {
					System.out.println('[' + getClass().getSimpleName() + "] Processing definition " + p);
					processDefinition(namespace, p);
				});
		} catch (IOException e) {
			e.printStackTrace();
			System.exit(1);
		}
	}
	
	protected abstract void processDefinition(String namespace, Path definitionPath);
}
