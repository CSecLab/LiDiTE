package it.unige.fdt.dittoregister;

import java.util.regex.Pattern;

public class Config {
    
    public static String getConfig(String key) {
	// From properties
	String fromProperties = System.getProperty(key);
	if (fromProperties != null) {
	    return fromProperties;
	}
	// From env
	String fromEnv = System.getenv(key.replaceAll(Pattern.quote("."), "_").toUpperCase());
	if (fromEnv != null) {
	    return fromEnv;
	}
	// Feedback
	System.out.println("No configuration for property " + key);
	return null;
    }
    
    public static String getConfig(String key, String def) {
	String configured = getConfig(key);
	return configured == null ? def : configured;
    }
}
