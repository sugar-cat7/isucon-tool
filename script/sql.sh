. $TOOL_PATH/input.sh
echo "クエリ解析結果:$MESSAGE"
sudo pt-query-digest /var/log/mysql/mysql-slow.log | tee /home/isucon/logs/sql/$MESSAGE.txt
sudo echo -n >/var/log/mysql/mysql-slow.log
