(function fdtInterop() {
	// Persistent state
	const state = {};
	let stateName = "UNKNOWN";

	// Helpers
	function calculateStateName() {
		// Unpack state
		const gridInput = systemDefinition.getU().getEntry(0);
		const gridOutput = systemDefinition.getU().getEntry(1);
		// Calculate and return state
		if (gridInput === 0.0 && gridOutput === 0) {
			// Nothing is being exchanged with the network
			return "IDLE";
		}
		if (gridInput === 0.0) {
			// Output is > 0.0
			return "DISCHARGING";
		}
		if (gridOutput === 0.0) {
			// Input is > 0.0
			return "CHARGING";
		}
		// Input and output are both >= 0
		return "EXCHANGING";
	}
	function recalculateStateName() {
		const name = calculateStateName();
		stateName = name;
		console.log('State name: ' + stateName);
	}
	
	// Functions exported to FDT
	return {
	  batteryEmpty: (gStopData) => {
	    console.log('Battery empty');
	    
	    // Stop delivery of power to grid
	    systemDefinition.getU().setEntry(1, 0.0);
	    console.log('Stopping power delivery');
	    
	    // Stop simulation
	    return "STOP";
	  },
	  batteryFull: (gStopData) => {
	    console.log('Battery full');
	    
	    // Stop power intake from grid
	    systemDefinition.getU().setEntry(0, 0.0);
	    console.log('Stopping power intake');
	    
	    // Stop simulation
	    return "STOP";
	  },
	  getStateName: () => {
	  	// Simply return the system status
	  	return stateName;
	  },
	  endHandler: () => {
	  	// Recalculate current state name
	  	recalculateStateName();
	  	// Reset battery charge status to 0.0
	  	if (systemState[0] < 0) systemState[0] = 0.0;
	  },
	  stepCallback: (t, x, xDot, isLast) => {
	  	// Initialize state component if absent
	  	if (!state['lastT']) { state['lastT'] = t; }
	  	// Print system evolution every 1.0s
	  	if (t - state['lastT'] > 1.0) {
	  		console.log(`stepCallback says t = ${t} x = ${x} xDot = ${xDot} isLast = ${isLast}`);
	  		state['lastT'] = t;
	  	}
	  },
		fixedStepCallback: (t, x, xDot, isLast) => {
			console.log(`fixedStepCallback says t = ${t} x = ${x} xDot = ${xDot} isLast = ${isLast}`);
		},
	  handleCommand: (topic, featureId, headers, payload) => {
	  	console.log(`[msg] topic = ${topic} featureId = ${featureId} payload = ${payload} headers = ${headers}`);
			// Get command
			if (!payload) {
				return { statusCode: 403, payload: "Missing payload" };
			}
			if (!payload.get('cmd')) {
				return { statusCode: 403, payload: "Missing cmd in payload, found keys: " + Object.keys(payload) };
			}
	  	// Parse command
	  	const commandParts = payload.get('cmd').split(" ");
	  	const command = commandParts[0];
	  	const quantity = parseFloat(commandParts[1]);
	  	switch (command) {
	  	case "GIVE":
	  		if (systemState[0] <= 0.0) {
	  			return { statusCode: 403, payload: "Accumulator is empty" };
	  		}
	  		if (quantity < 0) {
	  			return { statusCode: 403, payload: "Quantity can't be negative" };
	  		}
	  		systemDefinition.getU().setEntry(1, quantity);
				return `Giving out ${quantity}`;
	  	case "TAKE":
	  		if (systemState[0] >= 140000.0) {
	  			return { statusCode: 403, payload: "Accumulator is full" };
	  		}
	  		if (quantity < 0) {
	  			return { statusCode: 403, payload: "Quantity can't be negative" };
	  		}
	  		systemDefinition.getU().setEntry(0, quantity);
				return `Taking in ${quantity}`;
	  	}
	  	return { statusCode: 403, payload: "Unknown command" };
	  }
	};
})()
