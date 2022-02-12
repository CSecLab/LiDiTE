package it.unige.fdt.scriptablesensor.model.feature.lut.values;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class LUTFeatureComponentValueTimeBased implements LUTFeatureComponentValue {

    private final TimeValuePairLUT<TimeValuePair> lut;

    @JsonCreator
    public LUTFeatureComponentValueTimeBased(@JsonProperty("lut") TimeValuePairLUT<TimeValuePair> lut) {
    	this.lut = lut;
    }

    public TimeValuePairLUT<TimeValuePair> getLut() {
    	return lut;
    }

	@Override
	public String toString() {
		return "LUTFeatureComponentValueTimeBased [lut=" + lut + "]";
	}

}
