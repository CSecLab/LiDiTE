package it.unige.fdt.scriptablesensor.model.feature.lut.values;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.fasterxml.jackson.annotation.JsonTypeInfo.As;
import com.fasterxml.jackson.annotation.JsonTypeInfo.Id;

@JsonTypeInfo(use = Id.NAME, include = As.EXISTING_PROPERTY, property = "type")
@JsonSubTypes({ @JsonSubTypes.Type(name = "timeBased", value = LUTFeatureComponentValueTimeBased.class),
	@JsonSubTypes.Type(name = "weekdayTimeBased", value = LUTFeatureComponentValueWeekdayTimeBased.class),
		@JsonSubTypes.Type(name = "fromJS", value = LUTFeatureComponentValueFromJavascript.class) })
public interface LUTFeatureComponentValue {

}
