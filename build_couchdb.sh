#!/bin/bash
set -e
git clone git://github.com/zpetr/build-couchdb.git
cd build-couchdb
git checkout otp-fix
git submodule init
git submodule update
( cd dependencies/couchdb; git checkout 1.6.1 )
( cd dependencies/otp; git checkout OTP-18.3.2 )
echo '@setfilename autoconf.info' > dependencies/autoconf-2.69/doc/autoconf.texi
echo '@setfilename automake.info' > dependencies/automake-1.11.2/doc/automake.texi
( cd dependencies/autoconf-archive; ed cfg.mk <<< $'g/@diff/d\nw'; git commit -a -m 'fix build' )
git commit -a -m 'fix build'
rake
