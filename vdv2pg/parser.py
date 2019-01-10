#!/usr/bin/env python3

from logging import getLogger
from csv import DictReader
import sqlalchemy as sa


logger = getLogger(__name__)


def get_column(atr, frm):
    if frm.startswith('num'):
        typ = sa.Float if '.' in frm else sa.Integer
    elif frm.startswith('char'):
        typ = sa.String
    else:
        raise NotImplementedError
    return sa.Column(atr, typ)


class Parser():
    def __init__(self, metadata, schema):
        self.metadata = metadata
        self.schema = schema

    def create_table(self, filename, file):
        file_headers = []
        table_args = {}
        for line in file:
            file_headers.append(line)
            key, *values = (s.strip() for s in line.split(';'))
            table_args[key] = list(map(str.lower, values))
            if line.startswith('frm'):
                break

        return sa.Table(
            table_args['tbl'][0].lower(),
            self.metadata,
            *(get_column(atr, frm) for atr, frm in
                zip(table_args['atr'], table_args['frm'])),
            schema=self.schema,
            comment="Created from file {} with header:\n    {}".format(
                filename, '    '.join(file_headers)),
        )

    @staticmethod
    def clean(dct):
        for k in dct:
            v = dct[k]
            if isinstance(v, str) and v.strip() == '':
                dct[k] = None

    def parse(self, conn, filename, encoding='Windows-1252'):
        with open(filename, encoding=encoding) as f:
            table = self.create_table(filename, f)  # seeks to end of header
            column_names = table.columns.keys()
            logger.debug(
                "Creating or updating table %s with columns (%s)",
                table.name, ', '.join(column_names))
            self.metadata.create_all(conn, tables=[table])
            reader = DictReader(f, fieldnames=['typ'] + column_names,
                                delimiter=';', skipinitialspace=True)
            for dct in reader:
                if dct.pop('typ') == 'rec':
                    self.clean(dct)
                    conn.execute(table.insert(), **dct)

            logger.info("Ingested %s", filename)
