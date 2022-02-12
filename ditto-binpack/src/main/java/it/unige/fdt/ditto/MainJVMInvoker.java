package it.unige.fdt.ditto;

import java.lang.management.ManagementFactory;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;

public class MainJVMInvoker extends AbstractMainInvoker {

    public MainJVMInvoker(Class<?> clazz) {
	super(clazz);
    }

    @Override
    public void run() {
	String javaBinary = Path.of(System.getProperty("java.home"), "bin", "java").toString();
	List<String> jvmArgs = ManagementFactory.getRuntimeMXBean().getInputArguments();

	// Build up command
	ArrayList<String> command = new ArrayList<>();
	command.add(javaBinary);
	command.addAll(jvmArgs);
	command.add("-cp");
	command.add(System.getProperty("java.class.path"));
	command.add(clazz.getName());

	ProcessBuilder processBuilder = new ProcessBuilder(command);
	processBuilder.inheritIO();

	while (true) {
	    try {
		System.out.println("Starting process: " + String.join(" ", command));
		Process process = processBuilder.start();
		process.waitFor();
	    } catch (Exception e) {
		e.fillInStackTrace();
	    }
	}
    }
}
