#!/usr/bin/env python3

"""
Tool for dumping VDV 451 data into a database.

This is intended to quickly analyze the content of a collection of VDV files in
the VDV 451 format. By running this script a new schema is created and filled
with one table per inuput file. Some known primary key mappings are used, you
can add more using a config-file (see `development.ini.dist` for an example).

After dumping the data a SQL script `apply_constraints.sql` is run with the
new schema. It sets foreign keys and indices. You may want to modify that to
fit your needs (some errors are to be expected if you didn't create all tabels
referenced there).
"""

from argparse import ArgumentParser
from configparser import ConfigParser
from contextlib import contextmanager
from logging import getLogger
from logging.config import fileConfig
from os.path import dirname, realpath, join
from subprocess import run

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.schema import CreateSchema
from sqlalchemy.exc import ProgrammingError

logger = getLogger(__name__)

HERE = dirname(realpath(__file__))
PRIMARY_KEYS = {
    "basis_ver_gueltigkeit": "ver_gueltigkeit",
    "einzelanschluss": "basis_version, einan_nr",
    "fahrzeug": "basis_version, fzg_nr",
    "firmenkalender": "basis_version, betriebstag",
    "flaechen_zone": "basis_version, fl_zone_typ_nr, fl_zone_nr",
    "fl_zone_ort": "basis_version, fl_zone_typ_nr",
    "lid_verlauf": "basis_version, li_lfd_nr, li_nr, str_li_var",
    "menge_basis_versionen": "basis_version",
    "menge_bereich": "basis_version, bereich_nr",
    "menge_fahrtart": "basis_version, fahrtart_nr",
    "menge_fgr": "basis_version, fgr_nr",
    "menge_fzg_typ": "basis_version, fzg_typ_nr",
    "menge_onr_typ": "basis_version, onr_typ_nr",
    "menge_ort_typ": "basis_version, ort_typ_nr",
    "menge_tagesart": "basis_version, tagesart_nr",
    "ort_hztf": "basis_version, fgr_nr, onr_typ_nr, ort_nr",
    "rec_anr": "basis_version, anr_nr",
    "rec_frt_hzt": "basis_version, frt_fid, onr_typ_nr, ort_nr",
    "rec_frt": "basis_version, frt_fid",
    "rec_hp": "basis_version, onr_typ_nr, ort_nr",
    "rec_lid": "basis_version, li_nr, str_li_var",
    "rec_om": "basis_version, onr_typ_nr, ort_nr",
    "rec_ort": "basis_version, onr_typ_nr, ort_nr",
    "rec_sel_zp": "basis_version, bereich_nr, onr_typ_nr, ort_nr, sel_ziel, "
                  "sel_ziel_typ, zp_onr, zp_typ",
    "rec_sel": "basis_version, bereich_nr, onr_typ_nr, ort_nr, sel_ziel, "
               "sel_ziel_typ",
    "rec_ueb": "basis_version, bereich_nr, onr_typ_nr, ort_nr, ueb_ziel_typ, "
               "ueb_ziel",
    "rec_umlauf": "basis_version, tagesart_nr, um_uid",
    "rec_ums": "basis_version, einan_nr, tagesart_nr, ums_beginn, ums_ende",
    "rec_znr": "basis_version, znr_nr",
    "sel_fzt_feld": "basis_version, bereich_nr, fgr_nr, onr_typ_nr, ort_nr, "
                    "sel_ziel, sel_ziel_typ",
    "ueb_fzt": "basis_version, bereich_nr, fgr_nr, onr_typ_nr, ort_nr, "
               "ueb_ziel_typ, ueb_ziel",
}


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
        '-c', '--config_file', type=str, metavar='CONFIG',
        help='Optional primary key and logging configuration')
    parser.add_argument(
        '--post_ingest_script', type=str,
        default=join(HERE, 'apply_constraints.sql'),
        help='Optional path to an alternative post-ingest SQL script')
    return parser


def configure(args):
    """Return engine and Session"""

    engine = create_engine(args.database_url)
    Session = sessionmaker(bind=engine)
    config = ConfigParser()
    config.read_dict({'primary_keys': PRIMARY_KEYS})

    if args.config_file:
        fileConfig(args.config_file, disable_existing_loggers=False)
        config.read(args.config_file)

    logger.info("Loaded configuration")
    return engine, Session, config


@contextmanager
def scoped_session(sessionmaker):
    session = sessionmaker()
    try:
        yield session
    finally:
        session.close()


def execute_sql_script(dsn, filename, schema):
    """Execute sql in file with the search-path set to schema"""

    with open(filename) as f:
        psql_input = "set search_path = {};\n{}".format(schema, f.read())
        run(["psql", dsn, "-f", "-"], input=psql_input, universal_newlines=True)


def main():
    from vdv2pg.parser import Parser

    args = get_argument_parser(__doc__).parse_args()
    engine, Session, config = configure(args)

    try:
        engine.execute(CreateSchema(args.schema))
    except ProgrammingError as e:
        logger.warning("Could not create schema '%s': %s", args.schema, e)
        exit(1)

    parser = Parser(engine, Session, args.schema, config['primary_keys'])
    for filename in args.input_file:
        parser.parse(filename)

    execute_sql_script(
        args.database_url,
        args.post_ingest_script,
        args.schema)


if __name__ == '__main__':
    main()
