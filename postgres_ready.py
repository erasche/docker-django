#!/usr/bin/env python
import os
import sys
import psycopg2


try:
    conn = psycopg2.connect(
        dbname=os.environ.get('PGDATABASE', 'postgres'),
        user=os.environ.get('PGUSER', 'postgres'),
        password=os.environ.get('PGPASSWORD', 'postgres'),
        host=os.environ.get('PGHOST', 'postgres')
    )

except psycopg2.OperationalError as e:
    print(e)
    sys.exit(-1)

sys.exit(0)
