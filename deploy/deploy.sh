#!/bin/bash

# TODO: EC2インスタンスのホスト名に変更する
HOSTS=(
  host1
  host2
  host3
)

# TODO: アプリケーション名を適切に変更する
APPLICATION_NAME=isucon

# remote上でgit-pullを行う
remote_pull() {
  for HOST in ${HOSTS[@]}; do
    ssh isucon@$HOST sh remote-pull.sh $APPLICATION_NAME
  done
}
