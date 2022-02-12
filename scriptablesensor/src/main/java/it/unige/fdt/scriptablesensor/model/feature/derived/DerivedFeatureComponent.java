package it.unige.fdt.scriptablesensor.model.feature.derived;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

import it.unige.fdt.scriptablesensor.model.feature.FeatureComponent;

public class DerivedFeatureComponent implements FeatureComponent<DerivedFeature> {
    
    private final List<DerivedFeatureComponentSource> sources;
    private final String callbackName;
    private final String name;
    
    @JsonCreator
    public DerivedFeatureComponent(@JsonProperty(value = "sources", required = true) List<DerivedFeatureComponentSource> sources, @JsonProperty(value = "callbackName", required = true) String callbackName, @JsonProperty(value = "name", required = true) String name) {
	this.sources = sources;
	this.callbackName = callbackName;
	this.name = name;
    }
    
    public List<DerivedFeatureComponentSource> getSources() {
        return sources;
    }
    
    public String getCallbackName() {
        return callbackName;
    }
    
    public String getName() {
        return name;
    }

    @Override
    public String toString() {
	return "DerivedFeatureComponent [sources=" + sources + ", callbackName=" + callbackName + ", name=" + name
		+ "]";
    }

}
