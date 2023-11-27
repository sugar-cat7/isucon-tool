#!/bin/bash

FILE=$1

if [ ! -e $FILE ]; then
  echo "$FILE not found"
  exit 1
fi

SED_ARGS=`egrep '([a-zA-Z0-9_]+\.Group\(|echo\.New\(\))' $FILE | sed -e 's/echo\.New()/echo\.Group\(\"\"\)/g' -e 's/^\t*\([a-zA-Z0-9]*\) := [a-zA-Z0-9_]*\.Group("\(.*\)".*$/s\/"\1"\/\2\/g/g'`

REGEX=""
for e in `egrep '[a-zA-Z0-9_]+\.(GET|POST|PATCH|PUT|DELETE)\("/.*"' $FILE | sed -e 's/^\t*//g' -e 's/^\([a-zA-Z0-9_]*\).*("\([a-zA-Z0-9_/:]*\)".*$/"\1"\2/g' | sort -r | uniq`; do
  for arg in $SED_ARGS; do
    e=`echo $e | sed -e $arg -e 's/:[a-zA-Z0-9_]*/[^\/]+/g'`
  done
  REGEX=$REGEX,$e
done

echo ${REGEX:1}