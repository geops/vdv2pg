Tool for dumping VDV 451 data into a database
---------------------------------------------

This is intended to quickly analyze the content of a collection of VDV files in
the VDV 451 format. By running this script a new schema is created and filled
with one table per inuput file. Some known primary key mappings are used, you
can add more using a config-file (see `development.ini.dist` for an example).

After dumping the data a SQL script `apply_constraints.sql` is run with the
new schema. It sets foreign keys and indices. You may want to modify that to
fit your needs (some errors are to be expected if you didn't create all tabels
referenced there).


### Installation

    pip install vdv2pg


### Usage

    usage: vdv2pg [-h] [--schema SCHEMA] [-c CONFIG]
                    [--post_ingest_script POST_INGEST_SCRIPT]
                    database_url input_file [input_file ...]

    positional arguments:
      database_url          Database to write to.
      input_file            Files to read data from

    optional arguments:
      -h, --help            show this help message and exit
      --schema SCHEMA       Schema to create tables in (default: vdv2pg)
      -c CONFIG, --config_file CONFIG
                            Optional primary key and logging configuration
      --post_ingest_script POST_INGEST_SCRIPT
                            Optional path to an alternative post-ingest SQL script

Example:

    vdv2pg --schema import01 postgresql:///vdv_imports *.X10
