sudo . $TOOL_PATH/input.sh
#要修正, sshでローカルからいい感じに実行するようにするかも
cd /home/isucon/benchmarker
bin/benchmarker | tee /home/isucon/logs/bench/$MESSAGE.txt
