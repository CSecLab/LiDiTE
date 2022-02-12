package it.unige.fdt.scriptablesensor.scripting.js;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.eclipse.ditto.json.JsonArray;
import org.eclipse.ditto.json.JsonObject;
import org.eclipse.ditto.json.JsonValue;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class JavascriptTranslator {

    private static final Logger LOGGER = LoggerFactory.getLogger(JavascriptTranslator.class);

    private JavascriptTranslator() {
    }

    private static Object prepareJsonArrayForJavaScript(JsonArray jsonArray) {
	List<Object> result = new ArrayList<>(jsonArray.getSize());
	jsonArray.forEach(element -> result.add(prepareForJavaScript(element)));
	return Collections.synchronizedList(result);
    }

    private static Object prepareJsonObjectForJavaScript(JsonObject jsonObject) {
	Map<String, Object> result = new HashMap<>(jsonObject.getSize());
	jsonObject.forEach(field -> result.put(field.getKeyName(), prepareForJavaScript(field.getValue())));
	return Collections.synchronizedMap(result);
    }

    private static Object prepareJsonValueForJavaScript(JsonValue jsonValue) {
	if (jsonValue instanceof JsonArray) {
	    return prepareJsonArrayForJavaScript((JsonArray) jsonValue);
	} else if (jsonValue instanceof JsonObject) {
	    return prepareJsonObjectForJavaScript((JsonObject) jsonValue);
	} else if (jsonValue.isBoolean()) {
	    return jsonValue.asBoolean();
	} else if (jsonValue.isDouble()) {
	    return jsonValue.asDouble();
	} else if (jsonValue.isLong()) {
	    return jsonValue.asLong();
	} else if (jsonValue.isInt()) {
	    return jsonValue.asInt();
	} else if (jsonValue.isString()) {
	    return jsonValue.asString();
	} else {
	    throw new IllegalArgumentException(jsonValue.getClass().getName());
	}
    }

    public static Object prepareForJavaScript(Object incomingObject) {
	// If null return null
	if (incomingObject == null) {
	    return null;
	}
	// Convert the value to a mutable object for JavaScript
	if (incomingObject instanceof JsonValue) {
	    return prepareJsonValueForJavaScript((JsonValue) incomingObject);
	} else {
	    LOGGER.error("No idea on how to create a javascript object for {}", incomingObject.getClass().getName());
	    return incomingObject;
	}
    }
}
