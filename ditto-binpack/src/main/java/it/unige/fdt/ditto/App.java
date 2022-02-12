package it.unige.fdt.ditto;

import java.util.Collection;
import java.util.List;

import org.eclipse.ditto.services.concierge.starter.ConciergeService;
import org.eclipse.ditto.services.connectivity.ConnectivityService;
import org.eclipse.ditto.services.gateway.starter.GatewayService;
import org.eclipse.ditto.services.policies.starter.PoliciesService;
import org.eclipse.ditto.services.things.starter.ThingsService;
import org.eclipse.ditto.services.thingsearch.starter.SearchService;

public class App {

    private static final Collection<Class<?>> services = List.of(
	    // does not depend on anything
	    PoliciesService.class,
	    // depend on [ policies ]
	    ConciergeService.class, ThingsService.class, SearchService.class,
	    // depend on [ policies, concierge ]
	    ConnectivityService.class, GatewayService.class);

    private static void startMainThreadFor(ThreadGroup parentGroup, Class<?> clazz) {
	AbstractMainInvoker mainInvoker = new MainInvoker(clazz);
	ThreadGroup invocationThreadGroup = new ThreadGroup(parentGroup, clazz.getSimpleName());
	Thread invocationThread = new Thread(invocationThreadGroup, mainInvoker, clazz.getSimpleName());
	// Start thread
	invocationThread.start();
    }

    public static void main(String[] args) throws Exception {
	// System properties
	System.setProperty("akka.jvm-exit-on-fatal-error", "on");
	System.setProperty("akka.cluster.jmx.multi-mbeans-in-same-jvm", "on");
	System.setProperty("akka.cluster.shutdown-after-unsuccessful-join-seed-nodes", "600s");
	System.setProperty("akka.http.server.default-host-header", "ditto");
	System.setProperty("ditto.gateway.http.hostname", "0.0.0.0");
	// Start threads
	ThreadGroup mainGroup = new ThreadGroup("MainGroup");
	services.forEach(serviceClass -> startMainThreadFor(mainGroup, serviceClass));
    }
}
