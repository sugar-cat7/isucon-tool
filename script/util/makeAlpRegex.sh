#!/bin/bash

FILE=$1

if [ ! -e $FILE ]; then
  echo "$FILE not found"
  exit 1
fi

# Group化している箇所を抜き出す
# /は特殊文字なので=に置き換える
## 例
## group1 := e.Group("", testHandler) -> "group1"/
## group2 := e.Group("/", testHandler) -> "group2"/=
## group3 := e.Group("/hoge", testHandler) -> "group3"/=hoge
SED_ARGS=`egrep '([a-zA-Z0-9_]+\.Group\(|echo\.New\(\))' $FILE | \
sed -e 's/echo\.New()/echo\.Group\(\"\"\)/g' \
  -e 's/^\t*\([a-zA-Z0-9]*\) := [a-zA-Z0-9_]*\.Group("\(.*\)".*$/"\1"\2/g' \
  -e 's/\//=/g' \
  -e 's/"\([a-zA-Z0-9]*\)"\(.*\)/"\1"\/\2/g'`

REGEX=""

# ルーティング登録箇所から、変数名とパスを「"変数名"パス」の形式で
# その際、重複を排除し、正規表現部分を後ろに持っていくために降順でソートする
## 例
## e.POST("/post", postHandler) -> "e"/post
## group.GET("/hoge/fuga", getHandler) -> "group"/hoge/fuga
for e in `egrep '[a-zA-Z0-9_]+\.(GET|POST|PATCH|PUT|DELETE)\("/.*"' $FILE | sed -e 's/^\t*//g' -e 's/^\([a-zA-Z0-9_]*\).*("\([a-zA-Z0-9_/:]*\)".*$/"\1"\2/g' | sort -r | uniq`; do
  for arg in $SED_ARGS; do
    ## 変数名をパスに変換し、alpの正規表現に直す
    e=`echo $e | sed -e "s/$arg/g" -e 's/=/\//g' -e 's/:[a-zA-Z0-9_]*/[^\/]+/g' -e 's/\/\//\//g'`
  done
  REGEX=$REGEX,$e
done

echo ${REGEX:1}