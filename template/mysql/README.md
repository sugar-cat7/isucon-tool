# MySQL 周りの最適化に関する設定を集約する

- 設定を更新した場合は、設定内容の適用(サービスの再起動)をするべき

```bash
# 設定の適用
sudo systemctl restart mysql
# サービスの起動状況確認
sudo systemctl status mysql
```

## 各種設定

### mysqld の設定

mysqld.cnf 内を参照し、最適化を行う

## Go アプリ側の設定

DB のコネクションプールに関する設定を（抜けている場合）する。

まずは、CPU コア数の 2 倍程度の値を設定しておき、パフォーマンス最適化を進める中で調整する。

```go
+    db.SetMaxOpenConns(8)
+    db.SetMaxIdleConns(8)
     defer db.Close()
```

※CPU コア数やメモリの確認方法

```bash
grep processor /proc/cpuinfo
```
