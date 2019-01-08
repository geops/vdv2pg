#!/usr/bin/env python3

"""
Tool for dumping VDV 451 data into a database.

This is intended to quickly analyze the content of a collection of VDV files in
the VDV 451 format. By running this script a new schema is created and filled
with one table per inuput file. All data from the files will be dumped into the
tables.
"""

import logging
from argparse import ArgumentParser
from sqlalchemy import create_engine, MetaData
from sqlalchemy.schema import CreateSchema
from sqlalchemy.exc import ProgrammingError
from sqlalchemy.sql import text

logger = logging.getLogger(__name__)


def get_argument_parser(description=None):
    parser = ArgumentParser(description=description)
    parser.add_argument(
        'database_url', type=str, help='Database to write to.')
    parser.add_argument(
        'input_file', type=str, nargs='+', help='Files to read data from')
    parser.add_argument(
        '--schema', type=str, metavar='SCHEMA', default='vdv2pg',
        help='Schema to create tables in (default: vdv2pg)')
    parser.add_argument(
        '--append', action='store_true',
        help='Append to existing tables instead of creating a new schema')
    parser.add_argument(
        '--post_ingest_script', type=str,
        help='Optional path to a SQL script applied after ingesting the data')
    parser.add_argument(
        '-l', '--loglevel', type=str, metavar='LOGLEVEL',
        help='Control verbosity, possible values: DEBUG, INFO, WARNING, ERROR')
    return parser


def configure(args):
    """Return engine and Session"""

    engine = create_engine(args.database_url)
    metadata = MetaData()

    if args.loglevel:
        logging.basicConfig(level=getattr(logging, args.loglevel.upper(), None))

    logger.info("Loaded configuration")
    return engine, metadata


def execute_sql_script(conn, filename, schema):
    """Execute sql in file with the search-path set to schema"""

    with open(filename) as f:
        sql = text("set search_path = {};\n{}".format(schema, f.read()))

    conn.execute(sql)


def main():
    from vdv2pg.parser import Parser

    args = get_argument_parser(__doc__).parse_args()
    engine, metadata = configure(args)
    parser = Parser(metadata, args.schema)

    conn = engine.connect()
    with conn.begin():
        if not args.append:
            try:
                conn.execute(CreateSchema(args.schema))
            except ProgrammingError as e:
                logger.warning(
                    "Could not create schema '%s': %s", args.schema, e)
                exit(1)
        for filename in args.input_file:
            try:
                parser.parse(conn, filename)
            except Exception:
                logger.exception("Failed to ingest %s", filename)
                exit(1)

        if args.post_ingest_script:
            try:
                execute_sql_script(conn, args.post_ingest_script, args.schema)
            except Exception:
                logger.exception(
                    "Failed to execute %s", args.post_ingest_script)
                exit(1)


if __name__ == '__main__':
    main()
