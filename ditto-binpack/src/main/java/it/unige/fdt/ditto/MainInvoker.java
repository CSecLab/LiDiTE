package it.unige.fdt.ditto;

import java.io.IOException;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;

public class MainInvoker extends AbstractMainInvoker {

    private static final String[] noArgs = new String[] {};

    public MainInvoker(Class<?> clazz) {
	super(clazz);
    }

    private void startMain() {
	// Start main
	System.out.println(clazz.getSimpleName() + " starting");
	try {
	    // Grab main
	    Method mainMethod = clazz.getMethod("main", String[].class);
	    // Invoke it
	    mainMethod.invoke(null, (Object) noArgs);
	} catch (Exception e) {
	    e.printStackTrace();
	}
	// Print shutdown
	System.out.println(clazz.getSimpleName() + " terminated");
    }

    @Override
    public void run() {
	// Save current class loader
	ClassLoader prevClassLoader = Thread.currentThread().getContextClassLoader();
	while (true) {
	    try (URLClassLoader cl = new URLClassLoader(new URL[] {}, prevClassLoader)) {
		// Alter the default class loader
		Thread.currentThread().setContextClassLoader(cl);
		// Invoke main
		startMain();
		// Wait until all child threads terminate
		while (Thread.currentThread().getThreadGroup().activeCount() > 1) {
		    try {
			Thread.sleep(5000);
		    } catch (InterruptedException e) {
			e.printStackTrace();
		    }
		}
	    } catch (IOException ioe) {
		ioe.printStackTrace();
	    } finally {
		// Reset the class loader
		Thread.currentThread().setContextClassLoader(prevClassLoader);
	    }
	}
    }
}
