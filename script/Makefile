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

# PortForward
# ssh isucon@<Public IP> -fNL 1080:localhost:1080
.PHONY: pprof
pprof:
	go tool pprof -seconds 60 -http=localhost:1080 http://localhost:6060/debug/pprof/profile
# TODO: fix entrypoint
# _ "net/http/pprof"
# "runtime"

# func main() {
# runtime.SetBlockProfileRate(1)
# runtime.SetMutexProfileFraction(1)
# go func() {
# 	log.Fatal(http.ListenAndServe("localhost:6060", nil))
# }()
# }

