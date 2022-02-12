# config

This directory contains the configuration files for the framework

## BIND9

This contains the DNS zones

## Camunda

Inside of `cronjobs` there are the scripts which will be run by `camunda-scada-lts-cron`.

Inside of `definitions` there are the BPMN XML definitions which will be installed by `camunda-scada-lts-deployer`.

## camunda-scadalts-db

See the [dedicated README](camunda-scadalts-db/README.md)

## chassis-vpn

This stores the state (e.g. the CA certificates) for the VPN

## Ditto

Contains the policies and things which are deployed by `ditto-register`

## dovesnap

This stores the state for the Dovesnap network plugin

## NGINX

This contains a simple proxy pass configuration for NGINX allowing the proxy to expose an external service as if it was part of the infrastructure.

## OpenPLC

Contains inside of `trip.st` the structured text program for tripping the cabinets and inside of `modbus-slaves` the settings for linking a cabinet as modbus slave of the PLC.

## Performance sampler

Contains the Prometheus scrape configuration for the performance monitoring subsystem

## ScadaLTS

Inside of `uploads` it contains the images belonging to the SCADA dashboards

## Scriptable sensor

This contains the definitions and scripts for the various sensors

## Scriptable sensor cache

This contains the cache for REST API calls made by the scriptable sensor

## Windows

It contains the Windows images used for the operator workstation (omitted due to Windows being a licensed copy)

## Network configuration directories

These contain the OpenWRT configurations for the routers installed inside of the scenario

### enterprise

### industrial

### isp

### perimeter
