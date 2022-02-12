package it.unige.fdt.scriptablesensor.services.ditto;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import org.eclipse.ditto.client.live.LiveThingHandle;
import org.eclipse.ditto.client.live.messages.RepliableMessage;
import org.eclipse.ditto.model.base.common.HttpStatusCode;
import org.eclipse.ditto.model.base.headers.DittoHeaders;
import org.jboss.weld.environment.se.events.ContainerInitialized;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import it.unige.fdt.scriptablesensor.model.Sensor;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptCallbackService;
import it.unige.fdt.scriptablesensor.scripting.js.JavascriptTranslator;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.event.Observes;
import jakarta.inject.Inject;

@ApplicationScoped
public class DittoMessagingService {

    private static final Logger LOGGER = LoggerFactory.getLogger(DittoMessagingService.class);

    @Inject
    JavascriptCallbackService jsCallbackService;

    private static class MessageReply {

	public final HttpStatusCode statusCode;
	public final Object payload;
	public final String contentType;
	public final DittoHeaders headers;

	public MessageReply(HttpStatusCode statusCode, Object payload, String contentType,
		Map<String, String> headers) {
	    this.statusCode = statusCode;
	    this.payload = payload;
	    this.contentType = contentType;
	    this.headers = DittoHeaders.of(headers);
	}
    }

    private CompletableFuture<Object> getReplyFromJavaScriptFuture(String topic, String functionName,
	    RepliableMessage<?, Object> message) {
	// Call Javascript
	return CompletableFuture.supplyAsync(() -> jsCallbackService.callFunction(functionName, Object.class,
		// Topic
		topic,
		// Feature Id
		message.getFeatureId().orElse(null),
		// Materialize Ditto headers into a map
		message.getHeaders().entrySet().stream()
			.collect(Collectors.toUnmodifiableMap(Map.Entry::getKey, Map.Entry::getValue)),
		// Default the payload to null
		JavascriptTranslator.prepareForJavaScript(message.getPayload().orElse(null)))).thenApplyAsync(reply -> {
		    LOGGER.info("Javascript returned value: {}", reply);
		    return reply;
		});
    }

    private static String guessContentType(Object object) {
	if (object instanceof CharSequence) {
	    return "text/plain";
	}
	return "application/json";
    }

    @SuppressWarnings("unchecked")
    private CompletableFuture<MessageReply> getMessageReplyFuture(CompletableFuture<Object> messageRawReplyFuture) {
	return messageRawReplyFuture
		// Build message reply
		.thenApplyAsync(reply -> {
		    if (reply instanceof Map) {
			try {
			    Map<String, Object> replyMap = (Map<String, Object>) reply;
			    if (replyMap.containsKey("statusCode") && replyMap.containsKey("payload")) {
				return new MessageReply(
					// StatusCode
					HttpStatusCode.forInt((Integer) replyMap.get("statusCode"))
						.orElse(HttpStatusCode.OK),
					// Value
					replyMap.get("payload"),
					// Content type
					(String) replyMap.getOrDefault("contentType",
						guessContentType(replyMap.get("payload"))),
					// Headers
					(Map<String, String>) replyMap.getOrDefault("headers", Map.of()));
			    }
			} catch (ClassCastException e) {
			}
		    }
		    return new MessageReply(HttpStatusCode.OK, reply, guessContentType(reply), Map.of());
		})
		// Handle error
		.exceptionallyAsync(e -> {
		    LOGGER.error("Message reply failed", e);
		    // Headers
		    Map<String, String> headers = new HashMap<>();
		    headers.put("X-EXCEPTION-CLASSNAME", e.getClass().getName());
		    if (e.getCause() != null) {
			headers.put("X-EXCEPTION-CAUSE-CLASSNAME", e.getCause().getClass().getName());
		    }
		    return new MessageReply(HttpStatusCode.INTERNAL_SERVER_ERROR, "ERROR: " + e.getMessage(),
			    "text/plain", headers);
		});
    }

    private void replyToMessage(String topic, String functionName, RepliableMessage<?, Object> message) {
	LOGGER.info("Received message for topic {}", topic);

	Duration timeoutDuration = message.getTimeout().orElse(Duration.ofSeconds(30L));

	CompletableFuture<Object> messageFuture = getReplyFromJavaScriptFuture(topic, functionName, message)
		// Add JavaScript timeout
		.orTimeout(timeoutDuration.getSeconds(), TimeUnit.SECONDS);
	CompletableFuture<MessageReply> messageReplyFuture = getMessageReplyFuture(messageFuture);

	messageReplyFuture.thenAcceptAsync(reply -> message.reply().statusCode(reply.statusCode).headers(reply.headers)
		.payload(reply.payload).contentType(reply.contentType).send()).handleAsync((empty, err) -> {
		    if (err != null) {
			err.printStackTrace();
		    }
		    return null;
		}).thenRunAsync(() -> LOGGER.info("Sent message reply"));
    }

    void bindMessageHandlers(@Observes ContainerInitialized event, LiveThingHandle liveThingHandle,
	    JavascriptCallbackService jsCallbackService, Sensor sensor) {
	sensor.getMessageCallbackFunctions().forEach(callbackSpec -> {
	    // Unpack the callback specification
	    String functionName = callbackSpec.getFunctionName();
	    String topic = callbackSpec.getTopic();
	    // Bind message handlers
	    liveThingHandle.registerForMessage(
		    // Registration name
		    "ScriptableSensor(" + sensor.getName() + ')' + functionName + '>',
		    // Topic
		    topic,
		    // Message callback
		    message -> replyToMessage(topic, functionName, message));
	    LOGGER.info("Set {} as handler for {}", callbackSpec.getFunctionName(), callbackSpec.getTopic());
	});

    }
}
