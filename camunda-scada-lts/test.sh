#!/bin/bash

curl -s administrator:secret@10.0.0.20/api/2/things/FDT:energy-store-1/features | jq
curl -s administrator:secret@10.0.0.20/api/2/things/FDT:gas-generator-1/features | jq
curl -s administrator:secret@10.0.0.20/api/2/things/FDT:people-simulator/features | jq
curl -s administrator:secret@10.0.0.20/api/2/things/FDT:solar-panel-1/features | jq
curl -s administrator:secret@10.0.0.20/api/2/things/FDT:sun-simulator/features | jq
