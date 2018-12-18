Provides views for filling non-transparent parts of a image with a color

Usage
-----

### Installation

    pip install vdv452db


### Configuration

Add the database URL to the `[vdv452db]` configuration section:

    [vdv452db]
    sqlalchemy.url = postgresql:///your_database
    target_schema = vdv452db


Development Set-Up
------------------

Install:

    python3 -m venv env
    env/bin/pip install -e .
    cp development.ini.dist development.ini
    $EDITOR development.ini

Run:

    env/bin/vdv452db development.ini
