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

# 
$ docker run --rm -v ${pwd}:/min-caml -w /min-caml ocaml_practice make

```