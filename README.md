# ocaml_programing_basics
プログラミングの基礎をocamlで書いてみるリポジトリ

## 環境構築で利用した記事

* [min-caml を Mac で動かす](https://blog.ojisan.io/min-caml-for-mac/)
* [[Docker] CentOS6でwingを使わず最新のgitにする](https://shamaton.orz.hm/blog/archives/567)
* [yumコマンド実行時に Cannot retrieve repository metadata と出て失敗する(CentOS 6.4)](https://qiita.com/Higemal/items/5949e9d807ac278fe228)

## 環境構築
```
# imageのビルド
$ docker image build -t ocaml_practice

# 作業ディレクトリをdockerホスト上にマウントしてコンテナを起動する
$ docker run -it --rm -v `pwd`/min-caml:/test -w /test ocaml_practice


```

## 実行
```
# OCamlインタプリタの起動
$ ocaml

# OCamlインタプリタ上でファイルの読み込み
$ #use "ファイル名"

```