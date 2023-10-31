#!/bin/sh

. $TOOL_PATH/input.sh
echo "解析結果:$MESSAGE"

# 実行時点の日時を YYYYMMDD-HHMMSS 形式で付与したファイル名にローテートする
sudo mv /var/log/nginx/access.log /home/isucon/logs/nginx/access.log.$MESSAGE
# nginxにログファイルを開き直すシグナルを送信する
sudo nginx -s reopen

# Ex. mysqlのログ分析結果 -> mysql出ない場合は合わせてPathを見直す
sudo pt-query-digest /var/log/mysql/mysql-slow.log | tee /home/isucon/logs/sql/digest_$MESSAGE.txt
echo -n | sudo tee /var/log/mysql/mysql-slow.log