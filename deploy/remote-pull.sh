#!/bin/bash

# NOTE: ディレクトリ構成が違う可能性があるため注意
cd webapp

# 予期しないコンフリクトを防ぐためにstashしてからmasterにcheckout
git stash
git checkout master

git pull origin master
sudo systemctl restart "$1.go"
