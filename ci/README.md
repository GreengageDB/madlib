## How to run tests

Greengage 6:
```bash
docker container rm madlib -f
docker run --detach --entrypoint tail --env MADLIB_PORT=greenplum --name madlib --sysctl "kernel.sem=500 1024000 200 4096" --volume .:/home/gpadmin/madlib ghcr.io/greengagedb/greengage/ggdb6_ubuntu:latest -f /dev/null
docker exec madlib madlib/ci/install.bash
docker exec madlib su -p gpadmin madlib/ci/create.bash
docker exec madlib su -p gpadmin madlib/ci/test.bash install-check
docker exec madlib su -p gpadmin madlib/ci/test.bash dev-check
docker exec madlib su -p gpadmin madlib/ci/test.bash unit-test
```

Greengage 7:
```bash
docker container rm madlib -f
docker run --detach --entrypoint tail --env MADLIB_PORT=greenplum --name madlib --sysctl "kernel.sem=500 1024000 200 4096" --volume .:/home/gpadmin/madlib ghcr.io/greengagedb/greengage/ggdb7_ubuntu:latest -f /dev/null
docker exec madlib madlib/ci/install.bash
docker exec madlib su -p gpadmin madlib/ci/create.bash
docker exec madlib su -p gpadmin madlib/ci/test.bash install-check
docker exec madlib su -p gpadmin madlib/ci/test.bash dev-check
docker exec madlib su -p gpadmin madlib/ci/test.bash unit-test
```

PostgreSQL 15
```bash
docker container rm madlib -f
docker run --detach --entrypoint tail --env MADLIB_PORT=postgres --name madlib --sysctl "kernel.sem=500 1024000 200 4096" --volume .:/home/madlib --workdir /home ubuntu:22.04 -f /dev/null
docker exec madlib madlib/ci/install.bash
docker exec madlib su -p postgres madlib/ci/create.bash
docker exec madlib su -p postgres madlib/ci/test.bash install-check
docker exec madlib su -p postgres madlib/ci/test.bash dev-check
docker exec madlib su -p postgres madlib/ci/test.bash unit-test
```