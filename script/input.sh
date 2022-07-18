echo -n 'ログファイルにメッセージを入力してください[デフォルトはタイムスタンプ]: '
read MESSAGE
if [ -z $MESSAGE ]; then
    echo -n 'gitの最新のコミットメッセージを使用しますか？(y/N):'
    read yn
    case "$yn" in
    [yY]*) MESSAGE=$(git show | sed -n 5P | sed 's/^[ \t]*//' | sed 's/ /_/g') ;;
    *) MESSAGE=$(date +%Y-%m-%d-%H:%M) ;;
    esac
else
    echo $MESSAGE
fi
