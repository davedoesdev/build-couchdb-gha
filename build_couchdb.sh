#!/bin/bash
curdir="$(cd "$(dirname "$0")"; echo $PWD)"
set -e
git clone https://github.com/apache/couchdb
cd couchdb
git checkout 2.3.1
wget -O - http://ftp.mozilla.org/pub/mozilla.org/js/js185-1.0.0.tar.gz | tar zx
patch -p0 < "$curdir/js-1.8.5.patch"
pushd js-1.8.5/js/src
./configure
make
popd
./configure
make release ERL_CFLAGS="-I$PWD/js-1.8.5/js/src -I/usr/lib/erlang/usr/include" LIBRARY_PATH="$PWD/js-1.8.5/js/src/dist/lib"
cp js-1.8.5/js/src/dist/lib/libmozjs185.so rel/couchdb/lib/libmozjs185.so.1.0
