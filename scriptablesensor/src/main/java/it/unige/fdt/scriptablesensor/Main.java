package it.unige.fdt.scriptablesensor;

import org.jboss.weld.environment.se.Weld;

public class Main {
    public static void main(String[] args) {
	Weld weld = new Weld()
		// Register Main
		.addBeanClass(App.class);
	// Startup the DI container
	weld.initialize();
    }
}
