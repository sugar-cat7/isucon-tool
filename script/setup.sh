# alp install
wget https://github.com/tkuchiki/alp/releases/download/v1.0.10/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin/alp
rm alp_linux_amd64.zip
rm alp

# pt-query-digest install
sudo apt update
sudo apt install percona-toolkit

TOOL_PATH='/home/isucon/isucon-tool/script'

echo ". $TOOL_PATH/.bashrc" >>~/.bashrc
source ~/.bashrc

mkdir -p /home/isucon/logs/bench
mkdir -p /home/isucon/logs/sql
mkdir -p /home/isucon/logs/nginx
