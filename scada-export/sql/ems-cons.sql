-- Total buildings consumption
SELECT timestamp, name, value FROM scada_export_datapoints_with_names
WHERE name = 'Total buildings consumption';

