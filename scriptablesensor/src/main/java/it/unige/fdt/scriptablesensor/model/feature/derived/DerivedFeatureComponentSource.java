package it.unige.fdt.scriptablesensor.model.feature.derived;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class DerivedFeatureComponentSource {
    
    private final String thingId;
    private final String feature;
    private final String pointer;
    
    @JsonCreator
    public DerivedFeatureComponentSource(@JsonProperty(value = "thingId", required = true) String thingId, @JsonProperty(value = "feature", required = true) String feature, @JsonProperty(value = "pointer", required = true) String pointer) {
	this.thingId = thingId;
	this.feature = feature;
	this.pointer = pointer;
    }

    public String getThingId() {
        return thingId;
    }

    public String getFeature() {
        return feature;
    }

    public String getPointer() {
        return pointer;
    }

    @Override
    public String toString() {
	return "DerivedFeatureComponentSource [thingId=" + thingId + ", feature=" + feature + ", pointer=" + pointer
		+ "]";
    }
   
}
