# openplc

This container wraps an OpenPLC installation, allowing automatic configuration.

## Configuration

A structured text program can be automatically executed by putting it into `/data/main.st`

A custom mbconfig.cfg defining slave devices can be put in `/data/mbconfig.cfg`

An example mbconfig.cfg can be found under [one of the SPM cabinet configuration directories](../config/openplc/modbus-slaves/cabinet-biblioteca.cfg).
