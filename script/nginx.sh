. $TOOL_PATH/input.sh
echo "nginx解析結果:$MESSAGE"
sudo alp json </var/log/nginx/access.log | tee /home/isucon/logs/nginx/$MESSAGE.txt
sudo echo -n >/var/log/nginx/access.log
