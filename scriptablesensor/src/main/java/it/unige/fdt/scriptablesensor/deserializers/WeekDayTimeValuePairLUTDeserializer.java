package it.unige.fdt.scriptablesensor.deserializers;

import java.io.IOException;
import java.time.DayOfWeek;
import java.util.Iterator;
import java.util.Set;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import it.unige.fdt.scriptablesensor.model.feature.lut.values.TimeValuePair;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.TimeValuePairLUT;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.WeekDayTimeValuePairLUT;

public class WeekDayTimeValuePairLUTDeserializer extends StdDeserializer<WeekDayTimeValuePairLUT> {

	private static final long serialVersionUID = 3954710479435517347L;

	public WeekDayTimeValuePairLUTDeserializer() {
		super(WeekDayTimeValuePairLUT.class);
	}

	@Override
	public WeekDayTimeValuePairLUT deserialize(JsonParser p, DeserializationContext ctxt)
			throws IOException, JsonProcessingException {
		WeekDayTimeValuePairLUT lut = new WeekDayTimeValuePairLUT();
		JsonNode tree = p.readValueAsTree();
		// Should be an object
		if (!tree.isObject()) {
			ctxt.reportInputMismatch(handledType(), "LUT is not an object");
		}
		// Iterate its fields
		Iterator<String> fieldNamesIterator = tree.fieldNames();
		while (fieldNamesIterator.hasNext()) {
			String fieldName = fieldNamesIterator.next();
			// Parse day of week
			DayOfWeek dayOfWeek = DayOfWeek.valueOf(fieldName);
			// Delegate to other parser
			JsonNode fieldValue = tree.get(fieldName);
			TimeValuePairLUT<?> tvpl = ctxt.readValue(fieldValue.traverse(p.getCodec()), TimeValuePairLUT.class);
			// Pass to the lut
			lut.put(dayOfWeek, (TimeValuePairLUT<TimeValuePair>) tvpl);
		}
		// Check that all weekdays are present
		Set<DayOfWeek> missingDays = lut.getMissingDays();
		if (!missingDays.isEmpty()) {
			ctxt.reportInputMismatch(handledType(), "Incomplete LUT: weekdays {} missing", missingDays);
		}
		return lut;
	}

}
