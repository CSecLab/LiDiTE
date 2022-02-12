#!/bin/sh
set -e
curl \
  -H "Content-Type: application/json" \
  -X POST \
  --data @- \
  http://scada:8080/engine-rest/process-definition/key/ems/start <<EOF
{
  "variables": {
    "debug": { "value": true, "type": "Boolean" },
    "debug_simulated_batteryless_surplus": { "value": null },
    "debug_simulated_overall_surplus": { "value": null },
    "scadalts_api_host": { "value": "scada:8080" },
    "scadalts_api_username": { "value": "admin" },
    "scadalts_api_password": { "value": "admin" },
    "turbine_energy_store_charge_hi": { "value": 60.0 },
    "turbine_energy_store_charge_lo": { "value": 40.0 },
    "gas_turbine_rated_watts": { "value": 65000.0 },
    "es_max_exchange_rate": { "value": null },
    "turbine_start_hour": { "value": 11 },
    "turbine_end_hour": { "value": 15 }
  }
}
EOF