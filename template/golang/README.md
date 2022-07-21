# goで記述されたアプリケーションを触るためのポイントをメモしていく

## app.go更新後にやるべきこと
* コンパイル: isuconではおそらくgolang/setup.shが与えられるので、これをroot権限で実行すればOK
* サービスの再起動: 例

```bash
sudo systemctl restart isu-go
```

## 自作モジュールをapp.goに読み込む方法
* 結論: go.modファイルを作成し直す
* やり方
  * 前提: 次のようなディレクトリ構成とする
    * `golang/`
      * `app.go`
      * `go.mod`
      * `my-modules/`: 自作モジュール用Goファイルを格納していくところ
        * `module1`: ソースコード上部に`package module1`を記載すること
        * `module2`
        * `...`
  * Step.1: `app.go`から`my-modules/module1`へ任意の処理を抽出する
    * `app.go`に`import`予定の構造体や関数などは大文字から命名すること
  * Step.2: `app.go`で`import "my-modules"`する
  * Step.3: `go.mod`を削除する
  * Step.4: `golang/`にて`go mod init my-modules`を実行
  * Step.5: `golang/`にて`go mod tidy`を実行
* 参考文献
  * [【Go言語】GOPATHの外に作ったプロジェクトでサブパッケージをインポートする](https://zenn.dev/turara/articles/golang-import-subpackages)
  * ["package XXX is not in GOROOT" when building a Go project](https://stackoverflow.com/questions/61845013/package-xxx-is-not-in-goroot-when-building-a-go-project)