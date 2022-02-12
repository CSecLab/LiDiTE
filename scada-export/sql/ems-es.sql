-- Energy store charge percentage
SELECT timestamp, name, value FROM scada_export_datapoints_with_names
WHERE name = 'Energy store 1 charge percent';
