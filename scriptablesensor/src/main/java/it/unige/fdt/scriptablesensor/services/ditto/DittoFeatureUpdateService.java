package it.unige.fdt.scriptablesensor.services.ditto;

import java.util.Collections;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionException;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.TimeoutException;
import java.util.function.Predicate;

import org.eclipse.ditto.client.options.Options;
import org.eclipse.ditto.client.twin.TwinFeatureHandle;
import org.eclipse.ditto.client.twin.TwinThingHandle;
import org.eclipse.ditto.json.JsonFieldSelector;
import org.eclipse.ditto.json.JsonValue;
import org.eclipse.ditto.model.base.exceptions.DittoRuntimeException;
import org.eclipse.ditto.model.things.Feature;
import org.eclipse.ditto.model.things.Features;
import org.eclipse.ditto.model.things.Thing;
import org.jboss.weld.exceptions.IllegalArgumentException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.SensorFeatureUpdateMessage;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;

@ApplicationScoped
public class DittoFeatureUpdateService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DittoFeatureUpdateService.class);

    private CompletableFuture<Void> performFeatureUpdate(TwinFeatureHandle featureHandle, String pointer,
	    Object payload, Class<?> payloadClass) {
	if (payloadClass == Boolean.class) {
	    return featureHandle.putProperty(pointer, (Boolean) payload);
	} else if (payloadClass == String.class) {
	    return featureHandle.putProperty(pointer, (String) payload);
	} else if (payloadClass == Integer.class) {
	    return featureHandle.putProperty(pointer, (Integer) payload);
	} else if (payloadClass == Double.class) {
	    return featureHandle.putProperty(pointer, (Double) payload);
	} else if (payloadClass == JsonValue.class) {
	    return featureHandle.putProperty(pointer, (JsonValue) payload);
	} else {
	    LOGGER.error("Unknown payload {}", payloadClass.getName());
	    throw new IllegalArgumentException(payloadClass.getName());
	}
    }

    private CompletableFuture<Void> handleFeatureUpdateProblem(Throwable problem, TwinThingHandle twinThingHandle,
	    String featureName, CompletableFuture<Void> retryFuture) {
	if (problem instanceof CompletionException) {
	    CompletionException ce = (CompletionException) problem;
	    return handleFeatureUpdateProblem(ce.getCause(), twinThingHandle, featureName, retryFuture);
	} else if (problem instanceof DittoRuntimeException) {
	    DittoRuntimeException dre = (DittoRuntimeException) problem;
	    if (dre.getErrorCode().equals("things:feature.notfound")) {
		LOGGER.debug("Feature {} was not found", featureName);
		// Create feature
		return CompletableFuture.supplyAsync(() -> Feature.newBuilder().withId(featureName).build())
			.thenAcceptAsync(twinThingHandle::putFeature)
			.thenRunAsync(() -> LOGGER.info("Created feature {}", featureName))
			// Rerun original
			.thenComposeAsync(ignored -> retryFuture);
	    }
	} else if (problem instanceof TimeoutException) {
	    LOGGER.error("Feature update timed out");
	    return CompletableFuture.completedFuture(null);
	}
	LOGGER.error("Unknown exception", problem);
	throw new IllegalArgumentException(problem.getClass().getName());
    }
    
    private Set<String> createdTwinFeaturePairs = Collections.newSetFromMap(new ConcurrentHashMap<>());
    
    private CompletableFuture<Void> ensureFeatureExists(TwinThingHandle twinThingHandle, String featureName) {
    	String identifier = twinThingHandle.getThingEntityId().toString() + ':' + featureName;
    	if (createdTwinFeaturePairs.contains(identifier)) {
    		LOGGER.debug("{} was found, skipping feature creation", identifier);
    		return CompletableFuture.completedFuture(null);
    	}
    	JsonFieldSelector fieldSelector = JsonFieldSelector.newInstance("/features/" + featureName);
    	Feature seekedFeature = Feature.newBuilder().withId(featureName).build();
    	Predicate<Features> hasSeekedFeature = features -> features.getFeature(featureName).isPresent();
    	Predicate<Thing> thingHasSeekedFeature = thing -> thing.getFeatures().map(hasSeekedFeature::test).orElse(false);
    	return twinThingHandle.retrieve(fieldSelector)
    			.thenApplyAsync(thingHasSeekedFeature::test)
    			.thenComposeAsync(shouldCreate -> {
    				CompletableFuture<Void> setAsCreated = CompletableFuture.runAsync(() -> createdTwinFeaturePairs.add(identifier));
    				// Skip if feature already exists
    				if (!shouldCreate) {
    					LOGGER.debug("{} is present in Ditto, skipping put", identifier);
    					return setAsCreated;
    				}
    				// Add feature
    				return twinThingHandle.putFeature(seekedFeature)
    						.thenRunAsync(() -> createdTwinFeaturePairs.add(identifier))
    						.thenRunAsync(() -> LOGGER.info("Created feature {} for {}", featureName, twinThingHandle));
    			});
    }

    private CompletableFuture<Void> performFeatureUpdate(TwinThingHandle twinThingHandle, String featureName,
	    String pointer, Object payload, Class<?> payloadClass) {
	// Base update feature future
	CompletableFuture<Void> updateFeature = ensureFeatureExists(twinThingHandle, featureName)
		.thenApplyAsync(ignored -> twinThingHandle.forFeature(featureName))
		.thenComposeAsync(featureHandle -> performFeatureUpdate(featureHandle, pointer, payload, payloadClass));
	// Handle exceptions
	return updateFeature.exceptionallyComposeAsync(
		err -> handleFeatureUpdateProblem(err, twinThingHandle, featureName, updateFeature));
    }

    public void observeMessage(@Observes SensorFeatureUpdateMessage<?> updateMessage, TwinThingHandle twinThingHandle) {
	LOGGER.debug("Beginning to handle feature update {}", updateMessage);

	String pointer = '/' + updateMessage.getPropertyName();
	Object payload = updateMessage.getPayload();
	Class<?> payloadClass = updateMessage.getPayloadClass();

	performFeatureUpdate(twinThingHandle, updateMessage.getFeatureName(), pointer, payload, payloadClass)
		.whenCompleteAsync((empty, err) -> {
		    if (err != null) {
			LOGGER.error("Error while performing feature update", err);
		    } else {
			LOGGER.debug("Completed feature update for {}", updateMessage);
		    }
		});
    }
}
