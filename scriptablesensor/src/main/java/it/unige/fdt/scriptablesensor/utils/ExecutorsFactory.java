package it.unige.fdt.scriptablesensor.utils;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.enterprise.inject.Produces;
import jakarta.inject.Singleton;

@ApplicationScoped
public class ExecutorsFactory {

    public static void scheduleAtFixedRate(ScheduledExecutorService executorService, Logger logger, Runnable runnable,
	    double intervalSeconds) {
	Runnable wrappedRunnable = wrapExecution(logger, runnable);
	executorService.scheduleAtFixedRate(wrappedRunnable, 0L, Math.round(intervalSeconds * 1000.0),
		TimeUnit.MILLISECONDS);
    }

    public static Runnable wrapExecution(Logger logger, Runnable runnable) {
	return () -> {
	    try {
		runnable.run();
	    } catch (Exception e) {
		logger.error(e.getMessage(), e);
	    }
	};
    }

    @Singleton
    @Produces
    public ScheduledExecutorService getDefaultScheduledExecutorService() {
	return Executors.newScheduledThreadPool(Runtime.getRuntime().availableProcessors());
    }

}
