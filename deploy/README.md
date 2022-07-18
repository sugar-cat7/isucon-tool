# デプロイ用のスクリプト周り

## ファイル構成

ファイル名 | 説明 | 配置場所
--- | --- | ---
deploy-remote.sh | リモート上で実行されるシェルスクリプトをまとめたもの | remote@/home/isucon
deploy.sh | ローカル上に置いておくスクリプト | 任意
.gitignore | アプリケーションリポジトリ用の.gitignore | remote@/home/isucon/webapp

## 準備

1. deploy.sh上の`HOSTS`の部分をEC2インスタンスのIPアドレスまたはドメイン名に変更する  

~/.ssh/configの設定を書き換えている場合はそのホスト名でも良い  

2. `APPLICATION_NAME`をISUCON12のアプリケーション名に変更する  

例) ISUCON11予選の場合
```bash
APPLICATION_NAME=isucondition
```

3. ローカル環境上で以下のコマンドを実行  
```bash
source deploy.sh
```

***コマンドを永続化したい場合は以下のコマンドを実行***  
bashの場合
```bash
echo "source `pwd`/deploy.sh" >> ~/.bash_profile
```


zshの場合
```zsh
echo "source `pwd`/deploy.sh" >> ~/.zshrc
```

## コマンド

コマンド | 引数 | 説明
--- | --- | ---
remote_pull | - | EC2インスタンス上のmasterブランチで`git pull`を実行し、サーバーをリスタートするコマンド。もしEC2インスタンス上でコミットされていないものがあった場合、stashされる。
