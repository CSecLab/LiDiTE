package it.unige.fdt.scriptablesensor.services.javascript;

import java.util.concurrent.ScheduledExecutorService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import it.unige.fdt.scriptablesensor.model.feature.javascript.JavascriptFeature;
import it.unige.fdt.scriptablesensor.model.feature.javascript.JavascriptFeatureComponent;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptCallbackService;
import it.unige.fdt.scriptablesensor.services.FeatureComponentScheduler;
import it.unige.fdt.scriptablesensor.utils.ExecutorsFactory;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Event;
import jakarta.inject.Inject;

@ApplicationScoped
public class JavascriptFeatureComponentService implements FeatureComponentScheduler<JavascriptFeature, JavascriptFeatureComponent> {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(JavascriptFeatureComponentService.class);
    
    @Inject
    ScheduledExecutorService executorService;

    @Inject
    Event<SensorFeatureUpdateMessage<Object>> featureUpdateMessageBus;
    
    @Inject
    JavascriptCallbackService jsCallbackService;
    
    private void calculateComponent(String featureName, JavascriptFeatureComponent component) {
	Object callResult = jsCallbackService.callFunction(component.getFunctionName(), Object.class);
	featureUpdateMessageBus.fire(new SensorFeatureUpdateMessage<>(callResult, featureName, component.getName()));
    }
    
    @Override
    public void scheduleFeatureComponent(String featureName, JavascriptFeature feature, JavascriptFeatureComponent component) {
	ExecutorsFactory.scheduleAtFixedRate(executorService, LOGGER, () -> calculateComponent(featureName, component), feature.getUpdateFrequency());
    }

}
