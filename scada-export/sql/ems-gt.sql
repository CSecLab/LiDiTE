-- Gas turbine generated power
SELECT timestamp, name, value FROM scada_export_datapoints_with_names
WHERE name = 'Gas turbine 1 power (electric)';
