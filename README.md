# isucon-tool

isucon12 用最強ツール集

## 使い方

- isucon user へ変更
  `sudo su - isucon`

- /home/isucon でこのリポジトリをクローン

- ベンチマーカ用のインスタンスで benchmarker のありかを探して script/benchmarker.sh を修正

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

### nginx

json にフォーマットする設定を　`/etc/nginx/nginx.conf`に追加

```

   log_format json escape=json '{"time":"$time_iso8601",'
				    '"host":"$remote_addr",'
				    '"port":$remote_port,'
				    '"method":"$request_method",'
				    '"uri":"$request_uri",'
				    '"status":"$status",'
				    '"body_bytes":$body_bytes_sent,'
				    '"referer":"$http_referer",'
				    '"ua":"$http_user_agent",'
				    '"request_time":"$request_time",'
				    '"response_time":"$upstream_response_time"}';
    server{
	    access_log /var/log/nginx/access.log json;
    }
```

- config 設定後

```bash
# 設定ファイルに問題ないかテスト
$ nginx -t
# 設定を反映させるためにリロード
$ sudo systemctl restart nginx
```

- bench 実行後に alp json でログを見て、alias を良い感じに書き換える。
  `alias alpj=alp json --sort sum -r -m ‘/api/condition/.*,/api/isu/.*/graph,/api/isu/.*/icon,/api/isu/.*,/isu/.*/graph,/isu/.*/condition,/isu/.*’ -o count,method,uri,min,avg,max,sum < /var/log/nginx/access.log`
