# isucon-tool

isucon13 用最強ツール集

## 使い方

- isucon user へ変更
  `sudo su - isucon`

- /home/isucon でこのリポジトリをクローン

- AWS インスタンスの CPU アーキテクチャを確認し、ダウンロードする alp のバイナリを指定する。
  [参考](https://github.com/toshikingggg/isucon-tool/pull/2#discussion_r923375994)

- `/script/setup.sh` を実行

  - 必要なツールのインストール(alp, pt-query-digest)
  - log 出力先ディレクトリの作成
    - /home/isucon/logs/nginx/
    - /home/isucon/logs/sql/

## ログファイルのありか

`/home/isucon/logs`に sql,nginx それぞれの解析結果が保存されています。

# MySQL の設定

- mysql のコンソールから直接設定する場合(restart するとリセットされるので注意)

```
mysql> set global slow_query_log_file = '/var/log/mysql/mysql-slow.log';
mysql> set global long_query_time = 0;
mysql> set global slow_query_log = ON;
```

# アプリケーションプロセスの再起動

```bash
$ sudo systemctl restart isucon.go
```

# nginx の設定

- `template/nginx/`を参照してください。
- bench 実行後に alp json でログを見て、alias を良い感じに書き換えてください。

```bash
alias alpj=alp json --sort <avg/sum> -r -m <reg exp> -o count,method,uri,min,avg,max,sum < /var/log/nginx/<access log>
```

- \<reg exp\>の例
  - private-isu: "/posts/[0-9]+,/@\w+,/image/\d+"
  - isucon11 予選: "/api/condition/._,/api/isu/._/graph,/api/isu/._/icon,/api/isu/._,/isu/._/graph,/isu/._/condition,/isu/.\*"
