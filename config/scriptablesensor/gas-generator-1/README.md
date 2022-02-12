# Gas generator

Inspired by a Capstone C65 turbine.

## Simulated artefact

The simulated artefact emulates an on-off signal operated gas turbine, the power setpoint is always set to 100% of nominal power.

The only two commands available are START and STOP.

## Desired performance figures

Data is taken from table 1, figure 7, figure 11 and figure 12 of `A mathematical model for the dynamic simulation of low size cogeneration gas turbines within smart microgrids ~ S. Bracco, F. Delfino`

- Electrical power at 100% setpoint: 65 kW
- Desired EGT at steady state 100% setpoint: 637.8 degrees Celsius

|RPM (k)|Electrical power %|Electrical efficiency %|
|-------|------------------|-----------------------|
|     85|                50|                     25|
|     86|                60|                     26|
|     90|                70|                     27|
|     92|                80|                     28|
|     96|                90|                   28.5|
|   97.5|               100|                     29|
