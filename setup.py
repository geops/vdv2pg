from __future__ import absolute_import

import os

from setuptools import setup

here = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(here, 'README.md')) as f:
    README = f.read()
with open(os.path.join(here, 'requirements.txt')) as f:
    requires = [line.strip() for line in f
                if len(line) > 1 and not line.startswith('#')]

setup(
    name='vdv452db',
    version='0.0.1',
    description='Import VDV 542 files into a database',
    long_description=README,
    long_description_content_type='text/markdown',
    author='Milan Oberkirch | geOps',
    author_email='milan.oberkirch@geops.de',
    keywords='vdv542 sql database',
    license='MIT',
    classifiers=[
        "Programming Language :: Python :: 2.7",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python",
        "License :: OSI Approved :: MIT License",
    ],
    packages=['vdv452db'],
    install_requires=requires,
    entry_points="""\
        [console_scripts]
        vdv452db = vdv452db:main
    """,
  )
