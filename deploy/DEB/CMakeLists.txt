# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at

#   http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# ------------------------------------------------------------------------------
# Packaging with Debian
# ------------------------------------------------------------------------------
#
# Important: Set variables using set(... PARENT_SCOPE), so that the scope of the
# definition extends to the parent scope


# Get information about the environment

# -- Set Debian package specific variables ---------------------------------------
# get the architecture of Deb package. The name of the architecture is not
# always the same with ${CMAKE_SYSTEM_PROCESSOR}
if(NOT CPACK_DEBIAN_PACKAGE_ARCHITECTURE)
    execute_process(COMMAND dpkg --print-architecture
        OUTPUT_VARIABLE arch OUTPUT_STRIP_TRAILING_WHITESPACE)
      set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "${arch}" PARENT_SCOPE)
endif()

set(CPACK_DEBIAN_PACKAGE_VERSION "${MADLIB_PACKAGE_VERSION}" PARENT_SCOPE)
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "dev@madlib.apache.org" PARENT_SCOPE)

# When building against a specific Greengage major version (e.g. -DGREENGAGE_MAJOR_VERSION=6):
# - Install prefix: /opt/greengagedb/greengageN/madlib  (CMAKE_INSTALL_PREFIX from Dockerfile)
# - Debian package name becomes madlib6 / madlib7 (lowercase, no hyphen)
# - Depends is wired to the matching greengage6 / greengage7 package
# - postinst/postrm are generated from .in templates — no debconf interaction
set(CPACK_PACKAGING_INSTALL_PREFIX "/usr/local/madlib/Versions/${MADLIB_VERSION_STRING}" PARENT_SCOPE)
