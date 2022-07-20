# isucon-tool

isucon12 用最強ツール集

## 使い方

- isucon user へ変更
  `sudo su - isucon`

- /home/isucon でこのリポジトリをクローン

- ベンチマーカ用のインスタンスで benchmarker のありかを探して script/benchmarker.sh を修正

- AWS インスタンスの CPU アーキテクチャを確認し、ダウンロードする alp のバイナリを指定する。
  [参考](https://github.com/toshikingggg/isucon-tool/pull/2#discussion_r923375994)

```sh
#要修正
cd /home/isucon/benchmarker
bin/benchmarker | tee tee /home/isucon/logs/bench/$MESSAGE.txt
```

- `. ./script/setup.sh` を実行

  - 必要なツールのインストール(alp, pt-query-digest)
  - alias の設定
    - `pqd`: pt-query-digest でクエリ分析
    - `alpj`: alp で nginx のログを分析
    - `bench`: isucon 用のベンチマーカー実行

## ログファイルのありか

`~/isucon/logs`に sql,bench,nginx それぞれの解析結果が保存されています。

# MySQL の設定

- 今回に関しては mysql のコンソールから直接設定する(restart するとリセットされるので注意)

```
mysql> set global slow_query_log_file = '/var/log/mysql/mysql-slow.log';
mysql> set global long_query_time = 0;
mysql> set global slow_query_log = ON;
```

```bash
$ sudo systemctl restart isucon.go
```

# nginxの設定

* `template/nginx/`を参照してください。
* bench 実行後に alp json でログを見て、alias を良い感じに書き換えてください。
```bash
alias alpj=alp json --sort <avg/sum> -r -m <reg exp> -o count,method,uri,min,avg,max,sum < /var/log/nginx/<access log>
```
* \<reg exp\>の例
  * private-isu: "/posts/[0-9]+,/@\w+,/image/\d+"
  * isucon11 予選: "/api/condition/.*,/api/isu/.*/graph,/api/isu/.*/icon,/api/isu/.*,/isu/.*/graph,/isu/.*/condition,/isu/.*"