package it.unige.fdt.scriptablesensor.model.feature.lut.values;

import java.time.DayOfWeek;
import java.util.EnumMap;
import java.util.HashSet;
import java.util.Set;

import org.apache.commons.math3.analysis.UnivariateFunction;

import com.fasterxml.jackson.databind.annotation.JsonDeserialize;

import it.unige.fdt.scriptablesensor.deserializers.WeekDayTimeValuePairLUTDeserializer;

@JsonDeserialize(using = WeekDayTimeValuePairLUTDeserializer.class)
public class WeekDayTimeValuePairLUT extends EnumMap<DayOfWeek,TimeValuePairLUT<TimeValuePair>> {
	
	private static final long serialVersionUID = -1607567374607309125L;

	public WeekDayTimeValuePairLUT() {
		super(DayOfWeek.class);
	}
	
	public UnivariateFunction getInterpolatingFunction(DayOfWeek dayOfWeek) {
		// Check key
		if (!containsKey(dayOfWeek)) {
			throw new RuntimeException("Day of week " + dayOfWeek + " not found");
		}
		// Delegate to sub interpolator
		return get(dayOfWeek).getInterpolatingFunction();
	}
	
	public Set<DayOfWeek> getMissingDays() {
		Set<DayOfWeek> missingDays = new HashSet<>();
		for (DayOfWeek dayOfWeek : DayOfWeek.values()) {
			if (!containsKey(dayOfWeek)) {
				missingDays.add(dayOfWeek);
			}
		}
		return missingDays;
	}
}
