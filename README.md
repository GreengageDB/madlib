![](doc/imgs/magnetic-icon.png?raw=True) ![](doc/imgs/agile-icon.png?raw=True) ![](doc/imgs/deep-icon.png?raw=True)
=================================================
**MADlib<sup>&reg;</sup>** is an open-source library for scalable in-database analytics.
It provides data-parallel implementations of mathematical, statistical and
machine learning methods for structured and unstructured data.

[![Build Status](https://ci-builds.apache.org/job/Madlib/job/madlib-build/job/madlib2-master/badge/icon)](https://ci-builds.apache.org/job/Madlib/job/madlib-build/job/madlib2-master/)

Installation and Contribution
==============================
See the project website  [MADlib Home](http://madlib.apache.org/) for links to the
latest binary and source packages.

We appreciate all forms of project contributions to MADlib including bug reports, providing help to new users, documentation, or code patches. Please refer to [Contribution Guidelines](https://cwiki.apache.org/confluence/display/MADLIB/Contribution+Guidelines) for instructions.

For more installation and contribution guides,
please refer to the [MADlib Wiki](https://cwiki.apache.org/confluence/display/MADLIB/).

[Compiling from source on Linux](https://cwiki.apache.org/confluence/display/MADLIB/Installation+Guide#InstallationGuide-CompileFromSourceCompilingFromSource) details are
also on the wiki.

Detailed build instructions are available in [`ReadMe_Build.txt`](ReadMe_Build.txt)

User and Developer Documentation
==================================
The latest documentation of MADlib modules can be found at [`MADlib
Docs`](http://madlib.apache.org/docs/latest/index.html).


Architecture
=============
The following block-diagram gives a high-level overview of MADlib's
architecture.


![MADlib Architecture](doc/imgs/architecture.png?raw=True)


Third Party Components
======================
MADlib incorporates software from the following third-party components.  Bundled with source code:

1. [`libstemmer`](http://snowballstem.org/) "small string processing language"
2. [`m_widen_init`](licenses/third_party/_M_widen_init.txt) "allows compilation with recent versions of gcc with runtime dependencies from earlier versions of libstdc++"
3. [`argparse 1.2.1`](http://code.google.com/p/argparse/) "provides an easy, declarative interface for creating command line tools"
4. [`PyYAML 3.10`](http://pyyaml.org/wiki/PyYAML) "YAML parser and emitter for Python"
5. [`UseLATEX.cmake`](https://github.com/kmorel/UseLATEX/blob/master/UseLATEX.cmake) "CMAKE commands to use the LaTeX compiler"

Downloaded at build time (or supplied as build dependencies):

6. [`Boost 1.61.0 (or newer)`](http://www.boost.org/) "provides peer-reviewed portable C++ source libraries"
7. [`Eigen 3.2.2`](http://eigen.tuxfamily.org/index.php?title=Main_Page) "C++ template library for linear algebra"

Licensing
==========
Licensed to the Apache Software Foundation (ASF) under one or more contributor license agreements. See the [`NOTICE`](NOTICE) file distributed with this work for additional information regarding copyright ownership. The ASF licenses this project to You under the Apache License, Version 2.0 (the "License"); you may not use this project except in compliance with the License. You may obtain a copy of the License at [`LICENSE`](LICENSE).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

As specified in [`LICENSE`](LICENSE) additional license information regarding included third-party libraries can be
found inside the [`licenses`](licenses) directory.

Release Notes
=============
Changes between MADlib versions are described in the
[`ReleaseNotes.txt`](RELEASE_NOTES) file.

Papers and Talks
=================
* [`MAD Skills : New Analysis Practices for Big Data (VLDB 2009)`](http://db.cs.berkeley.edu/papers/vldb09-madskills.pdf)
* [`Hybrid In-Database Inference for Declarative Information Extraction (SIGMOD 2011)`](https://amplab.cs.berkeley.edu/publication/hybrid-in-database-inference-for-declarative-information-extraction/)
* [`Towards a Unified Architecture for In-Database Analytics (SIGMOD 2012)`](http://www.cs.stanford.edu/~chrismre/papers/bismarck-full.pdf)
* [`The MADlib Analytics Library or MAD Skills, the SQL (VLDB 2012)`](http://www.eecs.berkeley.edu/Pubs/TechRpts/2012/EECS-2012-38.html)


Related Software
=================
* [`PivotalR`](https://github.com/pivotalsoftware/PivotalR) - PivotalR also
lets the user run the functions of the open-source big-data machine learning
package `MADlib` directly from R.
* [`PyMADlib`](https://github.com/pivotalsoftware/pymadlib) - PyMADlib is a python
wrapper for MADlib, which brings you the power and flexibility of python
with the number crunching power of `MADlib`.
