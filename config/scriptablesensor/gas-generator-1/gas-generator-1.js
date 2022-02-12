(function fdtInterop() {
	// Data
	const ratedElectricalPower = 65000
	const dataPoints = [
		{ x: 0,     pwr_pct:  0, pwr_eff:   0.0 },
		{ x: 85000, pwr_pct: 50, pwr_eff:  0.25 },
		{ x: 86000, pwr_pct: 60, pwr_eff:  0.26 },
		{ x: 90000, pwr_pct: 70, pwr_eff:  0.27 },
		{ x: 92000, pwr_pct: 80, pwr_eff:  0.28 },
		{ x: 96000, pwr_pct: 90, pwr_eff: 0.285 },
		{ x: 97500, pwr_pct: 100, pwr_eff: 0.29 },
	]
	// Helpers
	function interpolateLinear(x, x1, x2, y1, y2) {
		const m = (y2 - y1) / (x2 - x1)
		const q = y1 - (m * x1)
		return m * x + q
	}
	function findClosestDataPoint(x) {
		function findLeft() {
			const minX = dataPoints[0].x
			if (x < minX) {
				return dataPoints[0]
			}
			for (let i = dataPoints.length - 1; i >= 0; i--) {
				if (dataPoints[i].x < x) {
					return dataPoints[i]
				}
			}
		}
		function findRight() {
			const maxX = dataPoints[dataPoints.length - 1].x
			if (x > maxX) {
				return dataPoints[dataPoints.length - 1]
			}
			for (let i = 0; i < dataPoints.length; i++) {
				if (dataPoints[i].x > x) {
					return dataPoints[i]
				}
			}
		}
		// Find left and right
		let left = findLeft()
		let right = findRight()
		// If they are equal, break the ties
		if (left === right) {
			const leftIndex = dataPoints.findIndex(e => e.x === left.x)
			const rightIndex = dataPoints.findIndex(e => e.x === right.x)
			if (leftIndex == 0) {
				right = dataPoints[rightIndex + 1]
			} else if (rightIndex == dataPoints.length - 1) {
				left = dataPoints[leftIndex - 1]
			} else {
				left = dataPoints[leftIndex - 1]
			}
		}
		// Generate interpolations
		const res = {
			x: x
		}
		for (const k in left) {
			// Skip x
			if (k === 'x') continue
			// Interpolate
			res[k] = interpolateLinear(x, left['x'], right['x'], left[k], right[k])
		}
		return {
			l: left,
			r: right,
			res: res
		}
	}
	function watt2kw(w) {
		return w / 1000.0
	}
	// Persistent state
	let lastT = null;
	let stateName = "OFF";
	let gearboxEngaged = false;
	// Functions exported to FDT
	const functions = {
		endHandler: () => {
			// Normalize RPM to 0.0 if stopping
			if (stateName === 'STOPPING' && systemState[0] < 100.0) {
				systemState[0] = 0.0;
			}
			// Reset RPM to 0.0
			if (systemState[0] < 0) systemState[0] = 0.0;
			// Reset Temperature to 0.0
			if (systemState[1] < 20) {
				systemState[1] = 20.0;
				if (stateName === 'STOPPING') {
					stateName = 'OFF';
				}
			}
			// Engage clutch if needed
			if (stateName === 'STARTING' && systemState[0] > 80000.0) {
				console.log('Engaging gearbox');
				gearboxEngaged = true;
				stateName = 'GENERATING';
			}
		},
		stepCallback: (t, x, xDot, isLast) => {
			// Initialize state component if absent
			if (!lastT) { lastT = t; }
			// Print system evolution every 1.0s
			if (t - lastT > 1.0) {
				console.log(`stepCallback says t = ${t} x = ${x} xDot = ${xDot} isLast = ${isLast}`);
				lastT = t;
			}
		},
		fixedStepCallback: (t, x, xDot, isLast) => {
			console.log(`fixedStepCallback says t = ${t} x = ${x} xDot = ${xDot} isLast = ${isLast}`);
		},
		getStateName: () => {
			return stateName;
		},
		getGearboxEngaged: () => {
			return gearboxEngaged;
		},
		getIgnitionValve: () => {
			return systemDefinition.getU().getEntry(1) >= 1.0;
		},
		getStartupValve: () => {
			return systemDefinition.getU().getEntry(0) >= 1.0;
		},
		getFrequencyHz: () => {
			if (functions['getGearboxEngaged']()) {
				const minRpm = dataPoints.find(e => e.pwr_pct ===  50)['x']
				const currentRpm = systemState[0]
				if (currentRpm >= minRpm) {
					return 50.0
				}
				return 49.0 + (currentRpm / minRpm)
			} else {
				return 0.0;
			}
		},
		getPowerKw: () => {
			if (functions['getGearboxEngaged']()) {
				const rpm = systemState[0]
				const powerPercentage = findClosestDataPoint(rpm)['res']['pwr_pct']
				return watt2kw((powerPercentage / 100.0) * ratedElectricalPower)
			}
			return 0.0;
		},
		getPowerThermal: () => {
			if (functions['getIgnitionValve']()) {
				const rpm = systemState[0]
				const powerPercentage = findClosestDataPoint(rpm)['res']['pwr_pct']
				const powerEfficiency = findClosestDataPoint(rpm)['res']['pwr_eff']
				const electricalWatts = (powerPercentage / 100.0) * ratedElectricalPower
				const thermalWatts = electricalWatts * (1 + (1 - powerEfficiency))
				return watt2kw(thermalWatts)
			}
			return 0.0;
		},
		ignition: () => {
			console.log('Ignition')
			systemDefinition.getU().setEntry(0, 0.0);
			systemDefinition.getU().setEntry(1, 1.0);
			return "STOP"
		},
		engageGearbox: () => {
			console.log('Engaging gearbox');
			gearboxEngaged = true;

			if (stateName === 'STARTING') {
				console.log('RPM threshold reached: engaging gearbox');
				stateName = 'GENERATING'
			}

			return "STOP";
		},
		disengageGearbox: () => {
			console.log('Disengaging gearbox');
			gearboxEngaged = false;

			if (stateName === 'STOPPING') {
				console.log('Generator is now freewheeling');
			}

			return "STOP";
		},
		cooledDown: () => {
			console.log('Poweroff complete')
			stateName = 'OFF';
			return "STOP";
		},
		injectNoise: () => {
			if (stateName === 'IDLE') {
				return;
			}
			// Javascript does not have gaussian distributions
			// B-M calculates pairs of gaussian variables
			function boxMullerGaussian(sigma) {
				// Sample two random variables in (0,1)
				let u1 = 0;
				while (u1 === 0) u1 = Math.random(); // Converting [0,1) to (0,1) for u1
				let u2 = 0;
				while (u2 === 0) u2 = Math.random(); // Converting [0,1) to (0,1) for u2
				// Calculate vector length
				const magnitude = sigma * Math.sqrt(-2.0 * Math.log(u1));
				// Calculate theta
				const theta = 2 * Math.PI * u2;
				// Calculate the two random variables
				const z1 = magnitude * Math.cos(theta);
				const z2 = magnitude * Math.sin(theta);
				// Either of the two values
				return [z1, z2];
			}
			// Calculate noises
			const noiseValues = boxMullerGaussian(0.125);
			// Noise injection
			for (let i = 0; i < noiseValues.length; i++) {
				systemState[i] += noiseValues[i];
			}
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
			switch (command) {
				case 'START':
					if (stateName === 'GENERATING') {
						return { statusCode: 200, payload: "Already running" };
					}
					if (stateName === 'STARTING') {
						return { statusCode: 200, payload: "Startup already in progress" };
					}
					if (stateName === 'STOPPING') {
						return { statusCode: 200, payload: "Turbine stopping, wait until power cycle completes" };
					}
					systemDefinition.getU().setEntry(0, 1.0);
					stateName = 'STARTING';
					return "Startup sequence initiated"
				case 'STOP':
					if (stateName === 'OFF') {
						return { statusCode: 200, payload: "System is already off" };
					}
					if (stateName === 'STARTING') {
						return { statusCode: 200, payload: "Turbine starting, wait until power cycle completes" };
					}
					if (stateName === 'STOPPING') {
						return { statusCode: 200, payload: "Shutdown already in progress" };
					}
					systemDefinition.getU().setEntry(1, 0.0);
					stateName = 'STOPPING';
					return "Shutdown sequence initiated"
			}
			return { statusCode: 403, payload: "Unknown command" };
		}
	};
	return functions;
})()
