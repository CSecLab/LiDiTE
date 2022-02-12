package it.unige.fdt.scriptablesensor.model.feature.lut.values;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class LUTFeatureComponentValueWeekdayTimeBased implements LUTFeatureComponentValue {

    private final WeekDayTimeValuePairLUT lut;

    @JsonCreator
    public LUTFeatureComponentValueWeekdayTimeBased(@JsonProperty("lut") WeekDayTimeValuePairLUT lut) {
    	this.lut = lut;
    }

    public WeekDayTimeValuePairLUT getLut() {
    	return lut;
    }

	@Override
	public String toString() {
		return "LUTFeatureComponentValueWeekdayTimeBased [lut=" + lut + "]";
	}

}
