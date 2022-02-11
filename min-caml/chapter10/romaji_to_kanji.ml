(* ekimei_t型, global_ekimei_listのimport *)
#use "chapter9/metro.ml"

(* 
  目的: ローマ字の駅名(string)と駅名リスト(ekimei_t list)を受け取って、
  その駅の漢字表記を文字列で返す
 *)
 (* romaji_to_kanji string -> elimei_t list -> string *)
let rec romaji_to_kanji str lst = match lst with
  [] -> ""
  |{kanji = kj; kana = kn; romaji = r; shozoku = s}::rest -> 
    if r = str
      then kj
      else romaji_to_kanji str rest

(* test *)
let test1 = romaji_to_kanji "" [] = ""
let test2 = romaji_to_kanji "hoge" [] = ""
let test3 = romaji_to_kanji "" global_ekimei_list = ""
let test4 = romaji_to_kanji "hoge" global_ekimei_list = ""
let test5 = romaji_to_kanji "hanzomon" global_ekimei_list = "半蔵門"