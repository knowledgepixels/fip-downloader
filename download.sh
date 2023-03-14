#!/usr/bin/env bash

set -e

mkdir -p files
./np help  # trigger downloading JAR file if not yet there

curl -X GET "http://grlc.nanopubs.lod.labs.vu.nl/api/local/local/get_all_indexes" -H "accept: text/csv" \
  | grep "_FIP_" \
  | sed -r 's|^([^,]*),([^,]*),.*$|echo Downloading \2...\n./np get -c \1 > files/\2.trig|g' \
  | bash

./np check files/*.trig
