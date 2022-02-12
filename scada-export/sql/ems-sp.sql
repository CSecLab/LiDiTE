-- Solar panel generated power
SELECT timestamp, name, value FROM scada_export_datapoints_with_names
WHERE name = 'Solar panel 1 power';
