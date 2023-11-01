# ビルドして、サービスのリスタートを行う
# リスタートを行わないと反映されないので注意
.PHONY: build
build:
	cd /home/isucon/webapp/go; \
	go build -o <service name> main.go; \
	sudo systemctl restart <service name>.go.service;

# pprofのデータをwebビューで見る
# VSCode Remote SSHしていれば、Auto Forwardedで閲覧できる
# サーバー上で sudo apt install graphvizが必要
# 公式：https://pkg.go.dev/net/http/pprof
.PHONY: pprof
pprof:
	go tool pprof -http=0.0.0.0:8080 /home/isucon/webapp/go/<service name> http://localhost:6060/debug/pprof/profile
# アプリファイルに下記を追記する
# _ "net/http/pprof"
# func main() {
# 	go func () {
# 		log.Fatal(http.ListenAndServe(":6060", nil))
# 	}()
# 	...
# }