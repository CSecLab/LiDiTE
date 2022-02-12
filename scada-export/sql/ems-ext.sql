-- External power draw
SELECT timestamp, name, value/1000 FROM scada_export_datapoints_with_names
WHERE name = 'Total external power draw';