# GraphvizServer
* DOT言語のコードを送ると画像が返ってくる
* herokuで動く
  * heroku管理画面からgraphvizのbuildpackを追加しなければいけない 
    * https://github.com/weibeld/heroku-buildpack-graphviz.git
# デモサイト
https://ubiregiinc.github.io/graphviz-server/index.html

# 仕様
* index.html にサンプルコードがあります
* bodyパラメータをつけて送るとレスポンスに `encoded_png` がBase64エンコードされた画像が入ってきます
  * クライアントではBase64デコードして表示する
* 画像のレンダリング(dotコマンド)に失敗した場合は `error_msg`に理由が書いています
* ステータスコードは常に200を返します

## LICENSE
MIT
