# alp install
wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.zip
unzip alp_linux_amd64.zip
sudo install ./alp /usr/local/bin/alp
rm alp_linux_amd64.zip
rm alp

# pt-query-digest install
sudo apt update
sudo apt install percona-toolkit

# ベンチマーカー後のログファイルを集計するディレクトリ
mkdir -p /home/isucon/webapp/logs/sql
mkdir -p /home/isucon/webapp/logs/nginx
