#!/bin/bash -l

set -exo pipefail

case "$MADLIB_PORT" in
    greenplum)
        source /usr/local/greengage-db-devel/greengage_path.sh
        source gpdb_src/gpAux/gpdemo/gpdemo-env.sh
    ;;
    postgres)
        export LD_LIBRARY_PATH=/usr/local/lib
        export PGDATA=/var/lib/postgresql/data
    ;;
esac

export PATH="$PATH:/usr/local/madlib/bin"
madpack -p "$MADLIB_PORT" -c /madlib "$1"
