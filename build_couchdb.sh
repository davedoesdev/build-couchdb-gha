#!/bin/bash
set -e
git clone https://github.com/apache/couchdb
cd couchdb
git checkout 3.3.2
./configure --spidermonkey-version 91
make release
