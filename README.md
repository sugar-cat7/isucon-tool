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
