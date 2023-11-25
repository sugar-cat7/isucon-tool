#!/bin/bash

FILE=$1

if [ ! -e $FILE ]; then
  echo "$FILE not found"
  exit 1
fi

REGEX=""

for e in `cat $FILE | egrep 'e\.(GET|POST|PATCH|PUT|DELETE)\("/.*"' | sed 's/^.*"\//\//g' | sed 's/".*$//g' | sed 's/:[A-Za-z0-9_]*/\[\^\/]\+/g' | sort -r | uniq`; do
  REGEX=$REGEX,$e
done

echo ${REGEX:1}