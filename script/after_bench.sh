#!/bin/sh

# 実行時点の日時を YYYYMMDD-HHMMSS 形式で付与したファイル名にローテートする
sudo mv /var/log/nginx/access.log /home/isucon/webapp/logs/nginx/access.log.`date +%Y%m%d-%H%M%S`
# nginxにログファイルを開き直すシグナルを送信する
sudo nginx -s reopen

# Ex. mysqlのログ分析結果 -> mysql出ない場合は合わせてPathを見直す
sudo pt-query-digest /var/log/mysql/mysql-slow.log | tee /home/isucon/webapp/logs/sql/digest_$(date +%Y%m%d%H%M).txt
echo -n | sudo tee /var/log/mysql/mysql-slow.log
