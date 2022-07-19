sudo . $TOOL_PATH/input.sh
# おそらくisuconの部分が本番異なる
systemctl restart isucon.go.service
systemctl status isucon.go.service
#要修正, sshでローカルからいい感じに実行するようにするかも
cd /home/isucon/benchmarker
bin/benchmarker | tee /home/isucon/logs/bench/$MESSAGE.txt
