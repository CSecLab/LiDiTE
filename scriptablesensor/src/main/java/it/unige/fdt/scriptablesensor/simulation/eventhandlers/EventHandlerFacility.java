package it.unige.fdt.scriptablesensor.simulation.eventhandlers;

import java.util.function.Function;

import org.apache.commons.math3.ode.events.EventFilter;
import org.apache.commons.math3.ode.events.EventHandler;
import org.apache.commons.math3.ode.events.FilterType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public abstract class EventHandlerFacility implements EventHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(EventHandlerFacility.class);

    protected final Function<EventData, Action> eventOccurredHandler;

    protected EventHandlerFacility(Function<EventData, Action> eventOccurredHandler) {
	this.eventOccurredHandler = eventOccurredHandler;
    }

    protected EventHandlerFacility(Action action) {
	this(s -> action);
    }

    protected EventHandlerFacility(int stateComponentIndex, double threshold) {
	this(Action.STOP);
    }

    @Override
    public Action eventOccurred(double t, double[] y, boolean increasing) {
	EventData eventData = new EventData(t, y, increasing);
	LOGGER.info("Hit {} at {}", getClass().getSimpleName(), eventData);
	return eventOccurredHandler.apply(eventData);
    }

    public EventHandler forDecreasingEvents() {
	return new EventFilter(this, FilterType.TRIGGER_ONLY_DECREASING_EVENTS);
    }

    public EventHandler forIncreasingEvents() {
	return new EventFilter(this, FilterType.TRIGGER_ONLY_INCREASING_EVENTS);
    }
}
