# Nginx 周りの最適化に関する設定を集約する

- 設定を更新した場合は、設定内容のテストと設定の適用(サービスの再起動)をするべき

```bash
# 設定内容のテスト
sudo nginx -t
# 設定の適用
sudo systemctl restart nginx
# サービスの起動状況確認
sudo systemctl status nginx
```

## 各種設定・最適化

### 序盤

- [ ] アクセスログを JSON 形式に変換する
- [ ] 伝送ファイル圧縮をする(gzip を on にする)
- [ ] 静的コンテンツを配信する(js/css/ico/gif/png/jpg などなど)
- [ ] worker_connections と worker_rlimit_nofile を増やす(=OS の ulimit を増やす)

### 中盤

- [ ] Nginx の CPU が高すぎる場合、gzip を off にする
- [ ] (API が同じクエリパラメータで同じ結果を返す場合)API レスポンスのキャッシュ設定をする([api-response-cache.conf](./api-response-cache.conf)を参照)
- [ ] nginx と Go アプリの接続をソケット通信にする([practice-for-isucon](https://github.com/naruwo-github/practice-for-isucon/blob/main/golang/app.go#L906))

### 終盤

- [ ] access.log はじめファイル出力を off にする

## worker connections に関して

- 結論: C / 4 未満 の範囲で指定

- OS で扱える最大ファイル数 A
  - 確認コマンド: `cat /proc/sys/fs/file-max`
- worker_process 数 B(仮想 CPU 数に同じ)
  - 確認方法: ベンチマーカー実行時に`top`コマンドで監視し、nginx プロセスを数える
- worker_limit_nofile C(=0.95D)
  - 単一の worker_process における、ファイルディスクリプタの上限値を表す
  - 算出方法: B × (設定する予定の worker_rlimit_nofile の値) < A となる値
    - 逆算すると D(設定すべき worker_rlimit_nofile の値) = A / B
    - ギリギリの値設定ではエラーが起こり得るので 5%ほど削減する -> 0.95×D

# 参考文献

- [Nginx] worker_connections と worker_rlimit_nofile の値は何がいいのか？: https://qiita.com/mikene_koko/items/85fbe6a342f89bf53e89
- Full Example Configuration: https://www.nginx.com/resources/wiki/start/topics/examples/full/
