# clear logs
echo -n | sudo tee /var/log/nginx/access.log
echo -n | sudo tee /var/log/nginx/error.log
echo -n | sudo tee /var/log/mysql/mysql-slow.log
echo -n | sudo tee /var/log/mysql/error.log