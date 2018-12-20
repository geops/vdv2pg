#!/usr/bin/env python3

from logging import getLogger
from csv import DictReader

import sqlalchemy as sa
from sqlalchemy.ext.declarative import as_declarative
from sqlalchemy.exc import ProgrammingError
from sqlalchemy.schema import Table

from vdv2pg import scoped_session

logger = getLogger(__name__)


@as_declarative()
class Base:
    def __repr__(self):
        return "<{} {} object at 0x{:x}>".format(
            type(self).__name__, type(self).__table__.name, id(self))


def get_column(atr, frm):
    if frm.startswith('num'):
        typ = sa.Float if '.' in frm else sa.Integer
    elif frm.startswith('char'):
        typ = sa.String
    else:
        raise NotImplementedError
    return sa.Column(atr, typ)


class Parser():
    def __init__(self, engine, session_cls, schema, pk_mapping=None):
        self.engine = engine
        self.session_cls = session_cls
        self.schema = schema
        self.pk_mapping = pk_mapping or {}

    def create_table(self, filename, file):
        file_headers = []
        table_args = {}
        for line in file:
            file_headers.append(line)
            key, *values = (s.strip() for s in line.split(';'))
            table_args[key] = list(map(str.lower, values))
            if line.startswith('frm'):
                break
        tbl = table_args['tbl'][0].lower()
        pk = sa.PrimaryKeyConstraint(
            *map(str.strip, self.pk_mapping[tbl].split(','))
        ) if tbl in self.pk_mapping else sa.Column(
            'id', sa.Integer, primary_key=True)

        class Model(Base):
            __table__ = Table(
                tbl,
                Base.metadata,
                *(get_column(atr, frm) for atr, frm in
                    zip(table_args['atr'], table_args['frm'])),
                pk,
                schema=self.schema,
                comment="Created from file {} with header:\n    {}".format(
                    filename, '    '.join(file_headers)),
            )
            column_names = table_args['atr']

        Model.__table__.create(bind=self.engine)
        return Model

    @staticmethod
    def clean(dct):
        for k in dct:
            v = dct[k]
            if isinstance(v, str) and v.strip() == '':
                dct[k] = None

    def parse(self, filename, encoding='Windows-1252'):
        with open(filename, encoding=encoding) as f:
            Model = self.create_table(filename, f)  # seeks to end of header
            logger.info("Created new table '%s'", Model.__table__.name)
            reader = DictReader(f, fieldnames=['typ'] + Model.column_names,
                                delimiter=';', skipinitialspace=True)

            try:
                with scoped_session(self.session_cls) as session:
                    for dct in reader:
                        if dct.pop('typ') == 'rec':
                            self.clean(dct)
                            session.add(Model(**dct))

                    session.commit()
            except Exception:
                logger.exception("Failed ingesting %s", filename)
            else:
                logger.info("Successfully ingested %s", filename)
