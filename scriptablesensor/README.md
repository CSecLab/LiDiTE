# scriptablesensor

Scriptable sensor is a software component designed to implement a rapid framework for the simulation of OT IoT devices interfacing with a Ditto digital twin server.

## Configuration

The following environment variables must be set:

- `FDT_DITTO_URL` the URL of the Ditto websocket API
- `FDT_DITTO_USERNAME` the username to use with Ditto
- `FDT_DITTO_PASSWORD` the password to use with Ditto
- `FDT_SENSOR_JSON` the file containing the sensor definition
- `FDT_SENSOR_JS` the file containing the sensor JavaScript logic

The following environment variables might be set:

- `FDT_RESTUTIL_INSECURE` set to `true` to disable x509 certificate validation in the `RESTUtil` object

### JSON sensor definition reference

#### Root object

The root object contains always a `name` and a `features` object.

```json
{
  "name": "<namespace>:<name>",
  "features": {
    "<feature1-name>": {
      "type": "<feature-type>",
      "<config-key1>": "<config-value1>"
    },
    "<feature2-name>": {
      "type": "<feature-type>",
      "<config-key1>": "<config-value1>"
    }
  },
  "messageCallbackFunctions": []
}
```

The `name` field has the same form of the target Ditto thingId

A feature member can have an arbitrary legal Ditto feature name but must have a `type` field.

The currently available feature types are:

- [Lookup table](#lut-feature)
- [System simulator](#system-simulator-feature)
- [Derived](#derived-feature)
- [Javascript](#javascript-feature)

The `messageCallbackFunction` contains a list of [message callbacks](#message-callback-functions)

#### LUT feature

A LUT (LookUpTable) feature represents a feature whose evolution can be approximated by the interpolation between some values.

```json
{
  "type": "LUT",
  "updateFrequency": 10.0,
  "components": [],
  "updateCallbacks": []
}
```

`type` must be the value `LUT`.

`updateFrequency` sets the number of seconds between each update sent to Ditto.

`components` is an array of LUT feature components in the form

```json
{
  "name": "<feature-property-name>",
  "value": {}
}
```

Where `value` is a LUT feature component generator.

Currently available LUT feature component generators are:

- [Time based generator](#lut-feature-time-based-component)
- [Weekday time based generator](#lut-feature-weekday-time-based-component)
- [JavaScript based generator](#lut-feature-javascript-based-component)

`updateCallbacks` is an array of strings representing the names of the JavaScript functions to call after each successful update.

Each callback will be called in the order of appearance in the array and be provided with three arguments:

1. (featureName): The name of the top level feature the update refers to.
2. (propertyName): The name of the property inside a feature the update refers to.
3. (value): The value that the feature property update has been updated to.

##### LUT Feature time based component

This can set as the `value` property of a `components` array entry.

It represents a value that depends on the current time of day.

```json
{
  "type": "timeBased",
  "lut": {
    "<HH1:MM1>": 0.0,
    "<HH2:MM2>": 10.0,
    "<HH3:MM3>": 0.0
  }
}
```

`type` must be `timeBased`.

`lut` contains key value pairs with the key indicating the time of day in HOURS:MINUTES format and the value representing the value.

The final value will be calculated as a linear interpolation between the closest two time intervals.

_We recommend to always include 00:00 and 24:00 values in the lut object, with the same value_

##### LUT Feature weekday time based component

This can set as the `value` property of a `components` array entry.

It represents a value that depends on the current time of day of a given weekday.

```json
{
  "type": "weekdayTimeBased",
  "lut": {
    "<WEEKDAY>": {
      "<HH1:MM1>": 0.0,
      "<HH2:MM2>": 10.0,
      "<HH3:MM3>": 0.0
    }
  }
}
```

`type` must be `weekdayTimeBased`.

`lut` contains key value pairs with the key indicating the day of week and the value having the same format as [LUT feature time based component](#lut-feature-time-based-component).

`<WEEKDAY>` is one of:

- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY`

##### LUT Feature JavaScript based component

This can set as the `value` property of a `components` array entry.

It represents a value that depends on a JavaScript calculation.

```json
{
  "type": "fromJS",
  "functionName": "<function-name>"
}
```

`type` must be `fromJS`.

`functionName` is the name of the exported function name that will be used for calculating the value.

The function will be called without arguments and **MUST** return a value.

#### System simulator feature

A system simulator feature represents a dynamic system whose governing equations can be represented as `xdot = Ax + Bu` with `A` and `B` matrices and `xdot`, `x`, `u` vectors.

System evolution is simulated via the integration of the characteristic differential equation.

```json
{
  "type": "systemSimulator",
  "stateRefreshIntervalSeconds": 1.0,
  "integrator": {},
  "system": {},
  "initialState": [],
  "initialInputs": [],
  "featureMappings": {},
  "eventHandlers": {},
  "stepHandlers": [],
  "intervalEndHandlers": []
}
```

`type` must be `systemSimulator`.

`stateRefreshIntervalSeconds` indicates how much time advancement is allowed between subsequent Ditto updates.

`integrator` allows [configuring the integration options](#integrator-options).

`system` contains [the system definition matrices](#system-definition).

`initialState` is an array indicating the initial values of the state variables.

`initialInput` is an array containing the initial values of the system inputs.

`featureMappings` allows to [configure what is sent to Ditto after each update](#feature-mappings).

`eventHandlers` allows to [configure integration stopping points](#event-handlers)

`stepHandlers` allows to [define periodic callbacks](#step-handlers)

`intervalEndHandlers` indicates an array of JavaScript functions that [will be called after each integration terminates](#interval-end-handlers)

##### Integrator options

The integrator options allow to customize the method used for integrating the state equations.

Some options are common to all integrators:

- `checkTolerance` convergence threshold in the event time search.
- `checkMaxTimeBetween` maximal time interval between switching function checks (this interval prevents missing sign changes in case the integration steps becomes very large).
- `checkMaxIterations` upper limit of the iteration count in the event time search.

###### Midpoint integrator

Runge-Kutta explicit integrator with this Butcher array:

```text
   0  |  0    0
  1/2 | 1/2   0
      |----------
      |  0    1
```

```json
{
  "type": "Midpoint",
  "stepSize": 0.001,
  "checkTolerance": 1e-9,
  "checkMaxTimeBetween": 1.0,
  "checkMaxIterations": 1000
}
```

`stepSize` is the fixed integration step size.

###### RungeKutta integrator

Classic fourth order Runge Kutta integrator with this Butcher array:

```text
   0  |  0    0    0    0
  1/2 | 1/2   0    0    0
  1/2 |  0   1/2   0    0
   1  |  0    0    1    0
      |--------------------
      | 1/6  1/3  1/3  1/6
```

```json
{
  "type": "RungeKutta",
  "stepSize": 0.001,
  "checkTolerance": 1e-9,
  "checkMaxTimeBetween": 1.0,
  "checkMaxIterations": 1000
}
```

`stepSize` is the fixed integration step size.

###### Luther integrator

Sixth order Runge-Kutta integrator, [the formula is available in the original paper](http://www.ams.org/journals/mcom/1968-22-102/S0025-5718-68-99876-1/S0025-5718-68-99876-1.pdf)

```json
{
  "type": "Luther",
  "stepSize": 0.001,
  "checkTolerance": 1e-9,
  "checkMaxTimeBetween": 1.0,
  "checkMaxIterations": 1000
}
```

`stepSize` is the fixed integration step size.

###### GraggBulirschStoer integrator

```json
{
  "type": "GraggBulirschStoer",
  "minStepSize": 0.0001,
  "maxStepSize": 0.001,
  "relativeTolerance": 0.0001,
  "absoluteTolerance": 0.0001,
  "checkTolerance": 1e-9,
  "checkMaxTimeBetween": 1.0,
  "checkMaxIterations": 1000
}
```

`minStepSize` minimal integration step.

`maxStepSize` maximum integration step.

`relativeTolerance` relative integration tolerance.

`absoluteTolerance` absolute integration tolerance.

###### HighamHall54 integrator

```json
{
  "type": "HighamHall54",
  "minStepSize": 0.0001,
  "maxStepSize": 0.001,
  "relativeTolerance": 0.0001,
  "absoluteTolerance": 0.0001,
  "checkTolerance": 1e-9,
  "checkMaxTimeBetween": 1.0,
  "checkMaxIterations": 1000
}
```

`minStepSize` minimal integration step.

`maxStepSize` maximum integration step.

`relativeTolerance` relative integration tolerance.

`absoluteTolerance` absolute integration tolerance.

##### System definition

System definition allows to specify the A and B matrices.

```json
{
  "A": [
    [ 1.0, 0.0 ],
    [ 0.0, 1.0 ]
  ],
  "B": [
    [ 1.0, 0.0 ],
    [ 0.0, 1.0 ]
  ]
}
```

In this example, `A` and `B` are identity matrices.

##### Feature mappings

This specifies the way in which calculations are to be presented to Ditto.

```json
{
  "state": {},
  "fromState": {},
  "fromJavaScript": {}
}
```

`state` specifies [direct mappings between the state and a property](#state-feature-mappings).

`fromState` specifies [mappings between the state and a property calculated via a function](#state-equation-mappings)

`fromJavaScript` specifies [script calculated values](#state-javascript-mappings)

###### State feature mappings

This mapping allows features to directly represent state variables.

```json
{
  "<prop1-name>": 0,
  "<prop2-name>": 1,
}
```

Each key will be the name of the property, the value is the index of the source state variable.

###### State equation mappings

This mapping allows to apply an equation to state variables and inputs.

The equation has the form

```text
y = Cx + Du
```

With `C`, `D` matrices, `x`, `u` vectors and `y` a scalar.

_To adapt a "standard" equation, you may need to "slice" its components_

```json
{
  "<prop1-name>": {
    "C": [
      [ 1.0 ]
    ],
    "D": [
      [ 0.0, 0.0 ]
    ]
  }
}
```

Each key will be the name of the property, the value is an object defining the `C` and `D` matrices.

###### State javascript mappings

This mapping allows to calculate values via JavaScript function calls

```json
{
  "<prop1-name>": "<function1-name>"
}
```

Each key will be the name of the property, the value is the JavaScript function name that will be called with no arguments and **MUST** return a value.

##### Event handlers

Event handlers allow to interrupt integration once particular checkpoints are hit.

```json
{
  "g-stop": []
}
```

`g-stop` is an array of [g-stop event handlers](#g-stop-event-handlers).

###### G-Stop event handlers

Allows to perform an action once a particular threshold is met.

```json
{
  "functionName": "<function-name>",
  "stateIndex": 0,
  "threshold": 0.0,
  "direction": "<direction>"
}
```

`functionName` is the name of the JavaScript function name.

`stateIndex` is the index of the state variable to monitor.

`threshold` is the value that the state variable should cross to invoke the g-stop handler.

`direction`, can be either:

- `INCREASING` call the event handler if the threshold is crossed from a lower value
- `DECREASING` call the event handler if the threshold is crossed from an higher value
- `ANY` call the event handler if the threshold is crossed from any other value

The g-stop handler function will be called with a single `gStopData` argument.

Such argument exposes three functions:

- `getT()` returns the current time
- `getY()` returns the current state variable array
- `isIncreasing` returns if the g-stop handler was hit from a lower value

The g-stop handler **MUST** return either of these strings:

- `CONTINUE` continue the integration as is (skip posting an update to Ditto)
- `RESET_DERIVATIVES` not implemented
- `RESET_STATE` not implemented
- `STOP` stop the integration, publishing the current status to Ditto

##### Step handlers

A step handler allows to call a JavaScript function every time the integrator advances a step.

It can be used for periodic callbacks or for performing particular actions such as noise value injections.

Two kind of step handlers are available:

- [Every step handler](#every-step-handler)
- [Fixed step handler](#fixed-step-handler)

###### Every step handler

This step handler will call the function at every integration step.

```json
{ 
  "functionName": "<function-name>"
}
```

`functionName` is the name of the JavaScript function.

The function will receive four arguments: `t`, `x`, `xDot`, `isLast`.

- `t` is the current simulation time
- `x` is the current state array
- `xDot` is the current state derivatives array
- `isLast` is a boolean indicating if the current step will be the last before integration ends

###### Fixed step handler

This step handler will call the function approximately at fixed time intervals.

```json
{ 
  "functionName": "<function-name>",
  "every": 1.0
}
```

`functionName` is the name of the JavaScript function.

`every` is the target time interval.

The function will receive four arguments: `t`, `x`, `xDot`, `isLast`.

- `t` is the current simulation time
- `x` is the current state array
- `xDot` is the current state derivatives array
- `isLast` is a boolean indicating if the current step will be the last before integration ends

##### Interval end handlers

An interval end handler indicates a function that will be called after each sub-simulation.

The handlers list is a string array containing the function names, that will be called in the order they were specified.

#### Message callback functions

These functions allow to handle Ditto thing commands on the live channel.

```json
{
  "functionName": "<function-name>",
  "topic": "<topic>"
}
```

`functionName` is the JavaScript function name.

`topic` is the Ditto message topic.

The JavaScript function will recive four arguments:

- `topic` which is the Ditto message topic.
- `featureId` which is the feature that received that message or `null` if none did.
- `headers` which is a map of Ditto headers
- `payload` which is the message contents

The function **MUST** return either:

- A string
- An object `{ statusCode: <code>, payload: <payload> }` that allows setting the statusCode of the reply

#### Derived feature

A derived feature represents a feature whose value depends on the values of other sensors.

```json
{
  "type": "derived",
  "updateFrequency": 10.0,
  "components": []
}
```

`type` must be the value `derived`.

`updateFrequency` sets the number of seconds between each update sent to Ditto.

`components` is an array of [derived feature components](#derived-feature-component).

Components are evaluated in the order they appear in the file.

##### Derived feature component

```json
{
  "sources": [
    {
      "thingId": "<thingId1>",
      "feature": "<featureName1>",
      "pointer": "<JSONPointer1>"
    }
  ],
  "callbackName": "<functionName>",
  "name": "<propertyName>"
}
```

`sources` is an array of references to other Ditto things.

The `pointer` property is a JSON pointer in string notation, for instance to access a simple property of an example thing:

```json
{
  "thingId": "ExampleNamespace:exampleName",
  "feature": "sampleFeatureName",
  "pointer": "/propertyName"
}
```

`callbackName` is the name of the function that will calculate the value, the function will receive a variable number of arguments, one for each entry in the sources array, representing the value of the referenced property.

The returned value will be used to update the feature, using the property name provided in `propertyName`.

#### Javascript feature

A Javascript feature represents a feature whose value depends on the execution of a Javascript function.

```json
{
  "type": "javascript",
  "updateFrequency": 10.0,
  "components": []
}
```

`type` must be the value `javascript`.

`updateFrequency` sets the number of seconds between each update sent to Ditto.

`components` is an array of [javascript feature components](#javascript-feature-component).

##### Javascript feature component

```json
{
  "name": "<propertyName>",
  "functionName": "<functionName>"
}
```

`functionName` is the name of the function that will calculate the value, the function will be invoked without any argument and __MUST__ return a value for each and every possible state.

The returned value will be used to update the feature, using the property name provided in `propertyName`.

### JavaScript sensor implementation suggestions

After the program start, the JavaScript file is parsed and an execution context is initialized.

Such execution context is preserved for the entire program lifecycle, allowing stateful effects and the implementation of complex logic.

In order for the JavaScript to be usable from the scriptable sensor, the execution should return an object containing the exported function names as keys and their instances as values.

We suggest the following format for the implementation of your own sensors

```javascript
(function fdtInterop() {
  // Persistent program state
  let stateVar1 = 0.0;
  let stateVar2 = {};
  let stateVar3 = false;
  // Implementation private functions
  function privateFunction1() {
    if (stateVar3) {
      console.log("Hi there");
    } else {
      console.log("Bye there");
    }
  }
  function privateFunction2() {
    return {};
  }
  function privateFunction3(x, y) {
    return x > y;
  }
  // Exported functions
  const exportedFunctions = {
    exportedFunctionName1: () => {
      console.log('Argument-less, void-returning function');
      stateVar3 = !stateVar3;
      privateFunction1();
    },
    exportedFunctionName2: () => {
      console.log('Argument-less, integer-returning function');
      return stateVar1;
    },
    exportedFunctionName3: (x, y) => {
      console.log(`Called with arguments ${x} ${y}`);
      return privateFunction3(x, y);
    }
  };
  // Return exported functions
  return exportedFunctions;
})()
```

#### JavaScript special context variables for REST API interaction

In order to allow interaction with external REST API, the Javascript context always include a `RESTUtil` object.

Such object exposes the following functions:

- `RESTUtil.doGet(<url>)` performs an HTTP GET request to the specificated `url` and returns the response body text
- `RESTUtil.doCacheableGet(<url>)` performs an HTTP GET request to the specificated `url` and returns the response body text, unless it has been already performed, returning the cached content

#### JavaScript special context variables for system simulator features

System simulator features' callbacks have special objects in their scope, they can be accessed from callbacks and other functions right after the first time a callback has been called.

`systemDefinition` is an object containing the A, B matrices and the U vector.

`systemDefinition.getA()` and `systemDefinition.getB()` return Apache commons Math RealMatrix objects and can be accessed from JavaScript as if they were local objects.

`systemDefinition.getU()` return Apache commons Math RealVector objects and can be accessed as before.

For instance:

- To get the first U component, `systemDefinition.getU().getEntry(0)` is a legitimate JavaScript function call.
- To set the second U component to 5.0, `systemDefinition.getU().setEntry(1, 5.0)` is allowed.

`systemState` contains the system state as a numeric array, providing also write access to the underlying state.

As an example, `systemState[1] = val` will assign to the second state component the value `val`.

`systemTime` contains the last simulation time `t`.
