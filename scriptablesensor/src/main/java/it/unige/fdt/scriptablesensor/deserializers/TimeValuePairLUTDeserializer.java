package it.unige.fdt.scriptablesensor.deserializers;

import java.io.EOFException;
import java.io.IOException;
import java.time.DayOfWeek;
import java.util.Iterator;
import java.util.regex.Pattern;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.JsonToken;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import it.unige.fdt.scriptablesensor.model.feature.lut.values.TimeValuePair;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.TimeValuePairLUT;

public class TimeValuePairLUTDeserializer extends StdDeserializer<TimeValuePairLUT<TimeValuePair>> {

	private static final long serialVersionUID = -984708114219569105L;
	
	private static final Pattern HHMM = Pattern.compile("[0-9]{1,2}:[0-9]{1,2}");

	public TimeValuePairLUTDeserializer() {
		super(TimeValuePairLUT.class);
	}

	@Override
	public TimeValuePairLUT<TimeValuePair> deserialize(JsonParser p, DeserializationContext ctxt)
			throws IOException, JsonProcessingException {
		TimeValuePairLUT<TimeValuePair> lut = new TimeValuePairLUT<>();
		// Read JSON
		JsonNode tree = p.readValueAsTree();
		// Should be an object
		if (!tree.isObject()) {
			ctxt.reportInputMismatch(handledType(), "LUT is not an object");
		}
		// Iterate over the fields
		Iterator<String> fieldNamesIterator = tree.fieldNames();
		while (fieldNamesIterator.hasNext()) {
			// HH:MM
			String fieldName = fieldNamesIterator.next();
			if (!HHMM.matcher(fieldName).matches()) {
				ctxt.reportInputMismatch(handledType(), "Time value not in HH:MM format");
			}
			// Value
			JsonNode fieldValue = tree.get(fieldName);
			if (!fieldValue.isNumber()) {
				ctxt.reportInputMismatch(handledType(), "LUT entry is not a number");
			}
			double fieldDoubleValue = fieldValue.asDouble();
			// Augment LUT
			lut.add(new TimeValuePair(fieldName, fieldDoubleValue));
		}
		// Return the LUT
		return lut;
	}

}
