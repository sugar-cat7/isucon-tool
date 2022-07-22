. $TOOL_PATH/input.sh
# おそらくisuconの部分が本番異なる systemctl -l | grep go
systemctl restart isucon.go.service
systemctl status isucon.go.service
#要修正, sshでローカルからいい感じに実行するようにするかも
cd /home/isucon/benchmarker
bin/benchmarker 2>&1 | tee /home/isucon/logs/bench/$MESSAGE.txt
