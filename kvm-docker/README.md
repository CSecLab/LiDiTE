# kvm-docker

This container allows the execution of virtualized workloads inside of a purposefully built container.

In order to use it:

- A qcow2 image file for the root disk has to be mounted at `/image/image`
- One or more DNS servers are to be included in the environment variable `DNS_SERVERS`
- One or more interfaces in format `name:ip` are to be included in the environment variable `CONT_IP`
  - These interfaces have to be added to the `ATTACH_IFACES` environment variable
- The VNC display resolution has to be included in the environment variables `DISPLAY_X` and `DISPLAY_Y`

The variable `USE_CLONE` whenever it is set to `y` allows to operate on a snapshot of the original image.

An example configuration is given in the [operator workstation module definition](../savona-operator.yml).
