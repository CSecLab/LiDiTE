#!/usr/bin/env python3
import docker
import MySQLdb
import sqlite3
import datetime
import time
from collections import deque
from statistics import mean

# Init DB
db = sqlite3.connect('export.db')

db.execute('DROP TABLE IF EXISTS scada_export_point_identities;')
db.execute('''
  CREATE TABLE scada_export_point_identities (
    xid TEXT NOT NULL,
    name TEXT NOT NULL,
    PRIMARY KEY (xid)
  ) WITHOUT ROWID;
''')

db.execute('DROP TABLE IF EXISTS scada_export_datapoints;')
db.execute('''
  CREATE TABLE scada_export_datapoints (
    timestamp TEXT,
    xid TEXT,
    value TEXT,
    FOREIGN KEY (xid) REFERENCES scada_export_point_identities(xid)
        ON UPDATE CASCADE
        ON DELETE CASCADE
  );
''')

db.execute('DROP VIEW IF EXISTS scada_export_datapoints_with_names;')
db.execute('''
CREATE VIEW scada_export_datapoints_with_names
AS
  SELECT scada_export_datapoints.timestamp, scada_export_datapoints.xid, scada_export_point_identities.name, scada_export_datapoints.value
  FROM scada_export_datapoints NATURAL JOIN scada_export_point_identities;
''')

db.execute('DROP VIEW IF EXISTS scada_export_available_points;')
db.execute('''
CREATE VIEW scada_export_available_points
AS
  WITH base AS (
    SELECT xid, name, COUNT(value) AS 'count', MIN(datetime(timestamp)) AS 'min_ts', MAX(datetime(timestamp)) AS 'max_ts'
      FROM scada_export_datapoints_with_names
      GROUP BY xid, name
      ORDER BY name ASC, xid ASC
  ), base_with_delta_m AS (
    SELECT *, (strftime('%s',max_ts) - strftime('%s',min_ts)) / 60.0 AS 'delta_m'
    FROM base
  ), with_per_minute AS (
    SELECT *, count / delta_m AS 'per_minute'
    FROM base_with_delta_m
  )
  SELECT xid, name, count, min_ts, max_ts, COALESCE(per_minute, 0) AS 'per_minute'
  FROM with_per_minute
  ORDER BY count DESC;
''')

# Find DB container
docker_client = docker.from_env()

def find_scada_db_container():
  def is_scada_db_container(c):
    return c.labels.get('com.docker.compose.service', '') == 'scada_db'
  containers = docker_client.containers.list()
  container = next(filter(is_scada_db_container, containers), None)
  if container == None:
    raise RuntimeError('Could not find Scada DB container')
  return container

scada_db_container = find_scada_db_container()
scada_db_container_nets = find_scada_db_container().attrs.get('NetworkSettings').get('Networks')
scada_db_container_nets = { k:v for k,v in scada_db_container_nets.items() if 'management' in k }
scada_db_container_management_net_name = list(scada_db_container_nets.keys())[0]
scada_db_container_management_ip = scada_db_container_nets.get(scada_db_container_management_net_name).get('IPAddress')

scada_db = MySQLdb.connect(scada_db_container_management_ip, "scadalts", "scadalts", "scadalts")

def run_query(query):
    c = scada_db.cursor()
    c.execute(query)
    while True:
        row = c.fetchone()
        if row != None:
            yield row
        else:
            break
    c.close()

# Print debug data

print('Tables:')
for table in run_query('SHOW TABLES'):
    table_name = table[0]
    table_columns = list(map(lambda x : x[0], run_query(f'SHOW COLUMNS FROM {table_name}')))
    print(f'{table_name}: {table_columns}')
dp_count = list(run_query('SELECT COUNT(*) FROM pointValues'))[0][0]
print(f'Datapoints count: {dp_count}')

# Import data to SQLite

cursor = db.cursor()
for i, row in enumerate(run_query('''
    SELECT dataPoints.xid, dataPoints.pointName, pointValues.ts, pointValues.pointValue
    FROM
        pointValues INNER JOIN dataPoints ON pointValues.dataPointId = dataPoints.id
    ORDER BY
        pointValues.ts ASC
''')):
    xid, name, ts, value = row
    ts = datetime.datetime.utcfromtimestamp(int(ts) / 1000)
    # Feedback
    print(f'{i+1}/{dp_count} - {round(i/dp_count*100,2)}% - {ts}', end='\r')
    # Insert name
    cursor.execute('''
        INSERT OR IGNORE INTO scada_export_point_identities(xid, name)
        VALUES (?, ?)
    ''', (xid, name))
    # Insert value
    cursor.execute('''
        INSERT INTO scada_export_datapoints(timestamp, xid, value)
        VALUES (?, ?, ?)
    ''', (ts, xid, value))
print('')
cursor.close()

# Create indexes

print('Creating indexes')
db.execute('CREATE UNIQUE INDEX dp_id_name_idx ON scada_export_point_identities (name)')
db.execute('CREATE UNIQUE INDEX dp_id_xid_idx ON scada_export_point_identities (xid)')
db.execute('CREATE INDEX dp_ts_idx ON scada_export_datapoints (timestamp ASC)')
db.execute('CREATE INDEX dp_xid_idx ON scada_export_datapoints (xid)')
print('Created indexes')

# Commit SQLite

db.commit()
db.execute('VACUUM')

print(f"Exported {db.execute('SELECT COUNT(*) FROM scada_export_datapoints').fetchone()[0]} values")
print(f"Datapoint count = {db.execute('SELECT COUNT(DISTINCT xid) FROM scada_export_point_identities').fetchone()[0]}")
print(f"Datapoint names = {sorted([ x[0] for x in db.execute('SELECT DISTINCT name FROM scada_export_point_identities').fetchall() ])}")
print(f"Minimum timestamp = {db.execute('SELECT MIN(timestamp) FROM scada_export_datapoints').fetchone()[0]}")
print(f"Maximum timestamp = {db.execute('SELECT MAX(timestamp) FROM scada_export_datapoints').fetchone()[0]}")

db.close()