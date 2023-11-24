sudo apt-get update
sudo apt-get install wget
sudo apt-get install unzip

# alp
wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin/alp
rm alp_linux_amd64.zip
rm alp

# pt-query-digest
sudo apt-get install percona-toolkit

# pprof
sudo apt-get install graphviz

# log directory
mkdir -p /home/isucon/webapp/logs/sql
mkdir -p /home/isucon/webapp/logs/nginx
