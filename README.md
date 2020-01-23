[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=geops/vdv2pg)](https://dependabot.com)

Tool for dumping VDV 451 data into a database
---------------------------------------------

This is intended to quickly analyze the content of a collection of VDV files in
the VDV 451 format. By running this script a new schema is created and filled
with one table per input file. Alternatively an existing schema may be used. 
All data from the files will be dumped into the tables.

After creating the tables and importing data you may also add definitions to
the schema using a SQL-script specified by the `--post_ingest_script` parameter.

We provide a sample script in `vdv2pg/apply_constraints.sql` that creates some
known constraints for a schema following the VDV 452 standard.

### Installation

    pip install vdv2pg


### Usage

    usage: vdv2pg [-h] [--schema SCHEMA] [--append]
                  [--post_ingest_script POST_INGEST_SCRIPT] [-l LOGLEVEL]
                  database_url input_file [input_file ...]

    positional arguments:
      database_url          Database to write to.
      input_file            Files to read data from

    optional arguments:
      -h, --help            show this help message and exit
      --schema SCHEMA       Schema to create tables in (default: vdv2pg)
      --append              Append to existing tables instead of creating a new
                            schema
      --post_ingest_script POST_INGEST_SCRIPT
                            Optional path to a SQL script applied after
                            ingesting the data
      -l LOGLEVEL, --loglevel LOGLEVEL
                            Control verbosity, possible values: DEBUG, INFO,
                            WARNING, ERROR

### Examples

Import into a new schema and execute `vdv2pg/apply_constraints.sql` on success:

    vdv2pg --schema=vdv --post_ingest_script=vdv2pg/apply_constraints.sql \
        postgresql:///vdv_imports *.X10

Update existing tables in the `vdv` schema:

    vdv2pg --schema=vdv --append postgresql:///vdv_imports *.X10
