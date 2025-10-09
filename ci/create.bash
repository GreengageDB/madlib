#!/bin/bash -l

set -exo pipefail

case "$MADLIB_PORT" in
    greenplum)
        source /usr/local/greengage-db-devel/greengage_path.sh
        pushd gpdb_src/gpAux/gpdemo
        make create-demo-cluster WITH_MIRRORS=true
        popd
        source gpdb_src/gpAux/gpdemo/gpdemo-env.sh
    ;;
    postgres)
        export LD_LIBRARY_PATH=/usr/local/lib
        export PGDATA=/var/lib/postgresql/data
        initdb --auth=trust --data-checksums --encoding=UTF8
        echo "logging_collector = 'on'" >>/var/lib/postgresql/data/postgresql.auto.conf
        pg_ctl -w start
    ;;
esac

createdb madlib

psql -ad madlib <<EOF
create extension if not exists plpython3u;
create schema if not exists madlib;
create extension if not exists madlib schema madlib;
select madlib.version();
EOF
