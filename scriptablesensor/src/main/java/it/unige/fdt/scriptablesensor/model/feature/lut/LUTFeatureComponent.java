package it.unige.fdt.scriptablesensor.model.feature.lut;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.FeatureComponent;
import it.unige.fdt.scriptablesensor.model.feature.lut.values.LUTFeatureComponentValue;

public class LUTFeatureComponent implements FeatureComponent<LUTFeature> {

    protected final String name;
    protected final LUTFeatureComponentValue value;

    @JsonCreator
    public LUTFeatureComponent(@JsonProperty("name") String name,
	    @JsonProperty("value") LUTFeatureComponentValue value) {
	this.name = name;
	this.value = value;
    }

    public String getName() {
	return name;
    }

    public LUTFeatureComponentValue getValue() {
	return value;
    }

    @Override
    public String toString() {
	return "LUTFeatureComponent [name=" + name + ", value=" + value + "]";
    }
}
