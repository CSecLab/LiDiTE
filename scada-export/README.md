# scada-export

This Python script allows exporting the historical datapoints from ScadaLTS into a SQLite3 database for further analysis and model validation.

## Prerequisites

- Python 3 with SQLite support
- Docker Python SDK
- The scadalts db container must be running

## Usage

`python3 app.py`

This will export the values into a local SQLite3 database called `export.db`.

The database will contain a table `scada_export` with the following columns:

- `xid`: Datapoint identifier inside ScadaLTS
- `name`: Datapoint name
- `value`: Datapoint value
- `timestamp`: Datapoint recorded date time

The generated database has already defined a variety of indexes to speedup analytical queries.

There is also a view called `scada_export_available_points` with the following columns:

- `xid`: Datapoint identifier inside ScadaLTS
- `name`: Datapoint name
- `count`: Number of measures for datapoint
- `min_ts`: Timestamp of first recorded measure
- `max_ts`: Timestamp of last recorded measure
