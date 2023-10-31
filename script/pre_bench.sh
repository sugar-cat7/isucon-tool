# おそらくisuconの部分が本番異なる systemctl -l | grep go
systemctl restart isucon.go.service
systemctl status isucon.go.service

# clear logs
echo -n | sudo tee /var/log/nginx/access.log
echo -n | sudo tee /var/log/nginx/error.log
echo -n | sudo tee /var/log/mysql/mysql-slow.log
echo -n | sudo tee /var/log/mysql/error.log