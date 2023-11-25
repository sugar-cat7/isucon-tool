# ユーティリティスクリプトの使い方

## makeAlpRegex.sh

echoのソースコードから、alpで使える正規表現を自動生成するためのスクリプト  
```bash
$ sh makeAlpRegex.sh <APIのエンドポイントの登録をしているGoのコードへのパス>

# 使用例(isucon12-final)
$ sh makeAlpRegex.sh main.go
/user/[^/]+/reward,/user/[^/]+/present/receive,/user/[^/]+/present/index/[^/]+,/user/[^/]+/item,/user/[^/]+/home,/user/[^/]+/gacha/index,/user/[^/]+/gacha/draw/[^/]+/[^/]+,/user/[^/]+/card/addexp/[^/]+,/user/[^/]+/card,/user,/login,/initialize,/health,/admin/user/[^/]+/ban,/admin/user/[^/]+,/admin/master,/admin/logout,/admin/login
```
