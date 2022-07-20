# Nginx周りの最適化に関する設定を集約する

* 設定を更新した場合は、設定内容のテストと設定の適用(サービスの再起動)をするべき
```bash
# 設定内容のテスト
nginx -t
# 設定の適用
sudo systemctl restart nginx
# サービスの起動状況確認
sudo systemctl status nginx
```

## アクセスログをJSON形式に変換する方法
* `nginx.conf`を参照

## 静的コンテンツ配信による最適化
* `application.conf`を参照

## 伝送ファイル圧縮による最適化
* `nginx.conf`を参照

## worker_connections最適化
* 結論: < C / 4 の範囲でよしなに指定
* OSで扱える最大ファイル数 A
  * 確認コマンド: `cat /proc/sys/fs/file-max`
* worker_process数 B
  * auto: 仮想CPU数に同じ
  * 確認方法: ベンチマーカー実行時に`top`コマンドで監視し、nginxプロセスを数える
* worker_limit_nofile C(=0.95D)
  * 単一のworker_processにおける、ファイルディスクリプタの上限値を表す
  * 算出方法: B * 設定する予定のworker_rlimit_nofileの値 < A以下の値
    * →逆算 D: A / B = 設定すべきworker_rlimit_nofileの値
    * →ギリギリの値設定ではエラーが起こり得るので5%ほど削減する: 0.95×D

# 参考文献
* [Nginx] worker_connectionsとworker_rlimit_nofileの値は何がいいのか？: https://qiita.com/mikene_koko/items/85fbe6a342f89bf53e89
* Full Example Configuration: https://www.nginx.com/resources/wiki/start/topics/examples/full/