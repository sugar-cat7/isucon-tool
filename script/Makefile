# ビルドして、サービスのリスタートを行う
# リスタートを行わないと反映されないので注意
.PHONY: build
build:
	cd /home/isucon/webapp/go; \
	go build -o <service name> main.go; \
	sudo systemctl restart <service name>.go.service;

# pprofのデータをwebビューで見る
# サーバー上で sudo apt install graphvizが必要
# 公式：https://pkg.go.dev/net/http/pprof
.PHONY: pprof
pprof:
	go tool pprof -http=0.0.0.0:8080 /home/isucon/webapp/go/<service name> http://localhost:6060/debug/pprof/profile