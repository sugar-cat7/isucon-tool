# Nginx周りの最適化に関する設定を集約する

## アクセスログをJSON形式に変換する方法
* `nginx.conf`を参照

## 静的コンテンツ配信による最適化
* `/sites-available/application.conf`を参照

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
  * 算出方法: B * 設定する予定のworker_rlimit_nofileの値 < A以下の値
    * →逆算 D: A / B = 設定すべきworker_rlimit_nofileの値
    * →ギリギリの値設定ではエラーが起こり得るので5%ほど削減する: 0.95×D
* 参考: [Nginx worker_connectionsとworker_rlimit_nofileの値は何がいいのか？](https://qiita.com/mikene_koko/items/85fbe6a342f89bf53e89)