Please read all sections marked with **. All others are optional and provide
background information.

MADlib 2.X requires python version 3.9. Other python 3 versions might work as well. Python 2.x is not supported.

MADlib requires the [GNU M4 Unix macro processor](https://www.gnu.org/software/m4/m4.html) which must be present for installation to succeed.

Currently supported database versions: GPDB 6 (with python3 extension), GPDB 7, PostgreSQL 15

The following python libraries are required for their associated modules:

- Installation: pyyaml==6.0.1, pyxb-x==1.2.6.1

- Various: numpy==1.25.2

- Deep Learning: dill==0.3.7, grpcio==1.57.0, protobuf==3.19.4, hyperopt==0.2.5, tensorflow == 2.10, scikit-learn==1.3.0

- XGBoost: pandas==2.0.3, xgboost==1.7.6

- KNN: scipy==1.11.2

- Unit tests: pgsanity

They can be instaled for example by following commands:
  pip3 install \
    dill==0.3.7 \
    grpcio==1.57.0 \
    hyperopt==0.2.5 \
    mock \
    numpy==1.25.2 \
    pandas==2.0.3 \
    protobuf==3.19.4 \
    pypmml \
    pyxb \
    pyxb-x==1.2.6.1 \
    pyyaml==6.0.1 \
    scikit-learn==1.3.0 \
    scipy==1.11.2 \
    tensorflow==2.10 \
    xgboost==1.7.6

Building and Installing from Source
===================================

** Run-time Requirements (required read):
-----------------------------------------

- None (except the C++ Standard Library)


** Build-time Requirements (required read):
-------------------------------------------

- CMake >= 2.8.4

- Internet connection to automatically download MADlib's dependencies if needed
  (Boost, Eigen). You can avoid this and build MADlib in a networkless mode
  by providing tarballs of 3 external dependencies. See configuration options below.

Optional:

- For generating user-level documentation (using `make doc`, see below):
  + doxygen >= 1.8.4, flex >= 2.5.33, and bison >= 2.4 to generate the
    user-level API reference in HTML format
  + A recent LaTeX installation for generating the formulas in the user-level
    documentation
  + graphviz >= 2.28 to generate graphs for the doxygen documentation

- For generating developer-level documentation (using `make devdoc`, see below):
  + doxygen, flex, and bison as above
  + git >= 1.7 to download/update the local MathJax installation, which is used
    for displaying formulas in the developer-level documentation

- For generating a complete installation package (RPM, Package Maker, etc.; see
  below):
  + PostgreSQL 15
  + Greenplum 6, 7
  + All requirements for generating user-level documentation (see above)

** Build-time Debian package dependencies (optional read):
-------------------------------------------

On Debian based platform you can install the required dependencies (aside from
Boost, Eigen and PyXB) by running the following command:
  apt-get install cmake g++ m4 python3 flex bison doxygen graphviz postgresql-server-dev-all texlive-full poppler-utils

** Build instructions (required read):
--------------------------------------

Uninstall libboost to avoid version conflict with MADlib and use the one downloaded at build time.

To install into greenplum binaries directory make

    source $GPHOME/greenplum_path.sh

From the MADlib root directory, execute the following commands:

	./configure
	make

To build the user-level documentation using doxygen, run:

    make doc

The developer documentation can be built by running `make devdoc` instead.

Optionally, install MADlib with

    make install

If you are missing a required library, the `./configure` or `make` step will
notice. Refer to your operating system's manual for instructions to install
the above prerequisites.


Notes:
------

- To speed things up, run `make -j X` instead of `make` where X is the number of
  jobs (commands) to run simultaneously. A good choice is the number of
  processor cores in your machine.
- MADlib depends on the linear-algebra library Eigen. We always copy it into the
  MADlib build directory during the build process.


Building an installation package (RPM, Package Maker, ...)
----------------------------------------------------------

To create a binary installation package, run the following sequence of commands:

    ./configure
    make doc
    make package

To create a complete installation package (for all supported DBMSs, equivalent
to what is offered on the MADlib web site), make sure that the build process is
able to locate the DBMS installations. For complete control, run `./configure`
with arguments `-D<DBMS>_PG_CONFIG=/path/to/pg_config` for all `<DBMS>` in
`POSTGRESQL_15`, `GREENPLUM_6`, and `GREENPLUM_7`.

To install MADlib in database use madpack, for example

    madpack -p greenplum -c /madlib install

Building an extension (for PostgreSQL, Greenplum)
----------------------------------------------------------

To create a extension, run the following sequence of commands:

    ./configure
    make extension-install

Then in database:

    CREATE SCHEMA madlib;
    CREATE EXTENSION madlib SCHEMA madlib;

To test MADlib use following options

    madpack -p greenplum -c /madlib install-check
    madpack -p greenplum -c /madlib dev-check
    madpack -p greenplum -c /madlib unit-test

or more cpecific

    madpack -p greenplum -c /madlib dev-check -t dbscan

Configuration Options:
----------------------

Depending on the environment, `./configure` might have to be called with
additional configuration parameters. The way to specify a parameter `<PARAM>`
is to add a command-line argument `-D<PARAM>=<value>`.

The following provides an overview of the
most important options. Look at `build/CMakeCache.txt` (relative to the MADlib
root directory) for more options, after having run `cmake` the first time.

- `CMAKE_BUILD_TYPE` (default: `RelWithDebInfo`)

    `Debug`, `Release`, `RelWithDebInfo`, or `MinSizeRel`

- `CMAKE_PREFIX_PATH` (default: *empty*)

    List (separated by `;` without trailing space) of additional search
    paths (for each `${PREFIX_PATH}` in `${CMAKE_PREFIX_PATH}`, binaries are
    searched for in `${PREFIX_PATH}/bin`, headers are searched for in
    `${PREFIX_PATH}/include`, etc.)

    For instance, if Boost header files are located under a non-standard
    location like `/opt/local/include/boost`, run
    `./configure -DCMAKE_PREFIX_PATH=/opt/local`.

- `CMAKE_INSTALL_PREFIX` (default: `/usr/local/madlib`)

    Prefix when installing MADlib with `make install`. All files will be
    installed within `${CMAKE_INSTALL_PREFIX}`.

- `<DBMS>_PG_CONFIG` (for `<DBMS>` in `POSTGRESQL_15`, `GREENPLUM_6`,
    and `GREENPLUM_7`. Default: *empty*)

    Path to `pg_config` of the respective DBMS. If none is set, the build
    script will check if `$(command -v pg_config)` points to a
    PostgreSQL/Greenplum installation.

    Note: If no `GREENPLUM<...>_PG_CONFIG` is specified, the build script will
    look for `/usr/local/greenplum-db/bin/pg_config`.

- `LIBSTDCXX_COMPAT` (default: *empty*)

    If GNU gcc is used to build MADlib and link against the GNU libstdc++, this
    option may be used to set the maximum version of libstdc++ acceptable as a
    runtime dependency (not supported on Mac OS X). E.g., if MADlib should
    require no more than the libstdc++ shipped with gcc 4.1.2, call
    `./configure` with `-DLIBSTDCXX_COMPAT=40102`.

    The current minimum value supported for option `LIBSTDCXX_COMPAT` is
    `40102`, and the latest version of gcc supported when setting this option is
    gcc 4.6.x.

    Setting this option will enable workarounds in
    `src/utils/libstdcxx-compatibility.cpp`.

- `BOOST_TAR_SOURCE` (default: *empty*)

    If no recent version of Boost is found (>= 1.47), Boost is downloaded
    automatically. Alternatively, the path to the (possibly gzip'ed)
    tarball can be specified by calling `./configure` with
    `-DBOOST_TAR_SOURCE=/path/to/boost_x.tar.gz`

- `EIGEN_TAR_SOURCE` (default: *empty*)

    Eigen is downloaded automatically, unless you call `./configure`
    with `-DEIGEN_TAR_SOURCE=/path/to/eigen_x.tar.gz`, in which case
    this tarball is used.

- `CREATE_RPM_FOR_UBUNTU` (default: *empty*)

    By default, we create a .deb madlib installer on Ubuntu. If this
    flag is set to 'True', we will create an RPM instead. Note that
    package alien must be installed for this to work.

- `CXX11` (default: *empty*)

    Compile with C++11 compatibility.  This may be required for building
    on newer platforms which don't come with support for pre-2011 C++
    standards.  For example, MacOSX >= 10.13 (XCode >= 10.x).  This option
    is also required for Boost >= 1.65 to work, as recent versions of
    Boost have also dropped support for older C++ standards.

Debugging
=========

For debugging it is helpful to generate an IDE project (e.g., XCode) with cmake
and then connect to the running database process:

0. Generate XCode project with CMake (in MADlib root directory):
   `mkdir -p build/Xcode && cd build/Xcode && cmake -G Xcode ../..`
1. Add an executable in XCode that points to the postgres binary
   (e.g., `/usr/local/bin/postgres`)
2. Do a `select pg_backend_pid();` in psql
3. Choose "Run" -> "Attach to Process" -> "Process ID..." in XCode and enter
   the process ID obtained in psql
