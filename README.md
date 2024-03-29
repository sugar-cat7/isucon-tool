# isucon-tool

isucon13 用最強ツール集

## 注意点

本番では、過去問や private-isu とは異なるディレクトリ構成かもしれないので、各種スクリプトの Path は適宜調整すること

ここでは`/home/isucon/`下に`webapp`ディレクトリが存在すると仮定している。

- private-isu では、`/home/isucon/private-isu/webapp/`となっている
- isucon11-qualify では、`home/isucon/webapp/`となっている

## 使い方

- インスタンスへ isucon ユーザでログイン

- /home/isucon/ でこのリポジトリをクローン

- インスタンスの CPU アーキテクチャを確認し、ダウンロードする alp のバイナリを指定する。
  [参考](https://github.com/toshikingggg/isucon-tool/pull/2#discussion_r923375994)

- `/script/setup.sh` を実行

  - 必要なツールのインストール(alp, pt-query-digest)
  - log 出力先ディレクトリの作成
    - /home/isucon/webapp/logs/nginx/
    - /home/isucon/webapp/logs/sql/

## ログファイルのありか

`/home/isucon/webapp/logs`に sql,nginx それぞれの解析結果が保存される。

- sql/digest_YYYYMMDD.txt：ベンチ実行後の mysql-slow.log に pt-query-digester を噛ませたもの
- nginx/access.log.YYYYMMDD：ベンチ実行後の access.log

※webapp の部分は、本番のアプリケーションフォルダに応じて更新する必要がある

## MySQL の設定

- mysql のコンソールから直接設定する場合(restart するとリセットされるので注意)

```
mysql> set global slow_query_log_file = '/var/log/mysql/mysql-slow.log';
mysql> set global long_query_time = 0;
mysql> set global slow_query_log = ON;
```

※スキーマ設定する SQL ファイルがある場合、その中に記述するのが良い

## nginx の設定

- `template/nginx/`を参照してください。

```bash
# alp command example
alp json --sort <avg/sum> -r -m <reg exp> -o count,method,uri,min,avg,max,sum < /home/isucon/webapp/logs/nginx/<access.log.YYYYMMDD>

# recommended: alias
alias alpj=alp json --sort <avg/sum> -r -o count,method,uri,min,avg,max,sum -m <reg exp>
# usage
alpj < access.log.xxx
```

- \<reg exp\>の例
  - private-isu: "/posts/[0-9]+,/@\w+,/image/\d+"
  - isucon11-q: "/api/condition/._,/api/isu/._/graph,/api/isu/._/icon,/api/isu/._,/isu/._/graph,/isu/._/condition,/isu/.\*"
  - isucon12-q: "/api/player/competition/[A-Za-z0-9]+/ranking,/api/organizer/competition/[A-Za-z0-9]+/score,/api/organizer/competition/[A-Za-z0-9]+/finish,/api/organizer/player/[A-Za-z0-9]+/disqualified,/api/player/player/[A-Za-z0-9]+"

# その他

過去の ISUCON 参加者の手順書や README をリンクしておく

- https://github.com/catatsuy/memo_isucon/blob/master/README.md
- https://gist.github.com/south37/d4a5a8158f49e067237c17d13ecab12a
- https://gist.github.com/minhquang4334/26e86a84731164581ed25d3fc7fe5211
