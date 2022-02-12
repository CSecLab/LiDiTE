package it.unige.fdt.scriptablesensor.model.feature;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;
import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;

import it.unige.fdt.scriptablesensor.model.feature.derived.DerivedFeature;
import it.unige.fdt.scriptablesensor.model.feature.javascript.JavascriptFeature;
import it.unige.fdt.scriptablesensor.model.feature.lut.LUTFeature;
import it.unige.fdt.scriptablesensor.model.feature.systemsimulator.SystemSimulatorFeature;

@JsonTypeInfo(use = Id.NAME, include = As.EXISTING_PROPERTY, property = "type")
@JsonSubTypes({
    	@JsonSubTypes.Type(name = "LUT", value = LUTFeature.class),
	@JsonSubTypes.Type(name = "systemSimulator", value = SystemSimulatorFeature.class),
	@JsonSubTypes.Type(name = "derived", value = DerivedFeature.class),
	@JsonSubTypes.Type(name = "javascript", value = JavascriptFeature.class)
})
public interface Feature {
}
