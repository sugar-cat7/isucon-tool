# alp install
wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin/alp
rm alp_linux_amd64.zip
rm alp

# pt-query-digest install
sudo apt update
sudo apt install percona-toolkit

TOOL_PATH='/home/isucon/isucon-tool/script'
echo "export TOOL_PATH='/home/isucon/isucon-tool/script'" >>~/.bashrc
echo ". $TOOL_PATH/.bashrc" >>~/.bashrc
source ~/.bashrc

# logs just after benchmarker
mkdir -p /home/isucon/logs/sql
mkdir -p /home/isucon/logs/nginx
