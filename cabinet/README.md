# cabinet

The cabinet simulates a smart building power switch, it exposes a ModBus IP interface.

Additionally, the cabinet allows simulating physical interactions via Docker container management.

## Configuration

Each instance is configured via environment variables

|variable|description|
|-|-|
|BASE|The cabinet base power consumption|
|MAXLOAD|The cabinet maximum power consumption|
|REFRESH|The interval for the power calculation|
|URL|The Docker API URL|
|VERBOSE|Whenever to enable verbose logging|
|BREAKER|Whenever to enable automatic circuit breaking|
|ID|The cabinet clients associated ID|

The Docker socket from the host has to be mounted to `/var/run/docker.sock` in the container, unless a different URL is specified.

## Modbus fields

Input registers (read-only):

- Offset 0: current power consumption in watts
- Offset 1: maximum power consumption in watts

Coil registers (read-write):

- Offset 0: power switch
- Offset 1: trip switch

## Interaction with Docker

The cabinet will read Docker container labels and will perform actions on them.

Available labels:

- `fdt.cabinetID` designates the ID of the cabinet this container is attached to, the cabinet will only act on containers having a cabinetID matching its configured id.
- `fdt.minload` sets a base load for when this container is active.
- `fdt.maxload` sets the maximum load for when this container is active.
- `fdt.protected` this label allows to attach a container to the cabinet but inhibiting potentially disruptive actions by the cabinet on it.

An attached container will consume an amount of power proportional to its cpu usage, as reported by the Docker daemon.
