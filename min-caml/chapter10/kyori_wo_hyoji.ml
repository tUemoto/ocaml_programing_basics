(* ekimei_t型, global_ekimei_list, global_ekimei_listのimport *)
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


(* 
  目的: 漢字の駅名ekimei1, ekimei2と駅間リスト(ekikan_t list)を受け取って
  ２駅間の距離を返す
 *)
 (* get_ekikan_kyori: string -> string -> ekikan_t list -> float *)
 let rec get_ekikan_kyori eki1 eki2 lst = match lst with
 [] -> max_float
 | {kiten = k; shuten = s; keiyu = ky; kyori = kr; jikan = j}::rest ->
   if k = eki1 && s = eki2 then kr
   else if k = eki2 && s = eki1 then kr
   else get_ekikan_kyori eki1 eki2 rest

(* 
  目的: ローマ字の駅名2つを受け取り、2駅間の距離をしらべ下記のフォーマットで検索結果を返却する
  フォーマット:
    (A駅、B駅ともに漢字表記とする)
    ２駅が直接つながっている -> A駅からB駅まではxkmです
    ２駅が直接つながっていない -> A駅とB駅はつながっていません
    存在しない駅が指定されている場合 -> ~という駅は存在しません 
 *)
(* kyori_wo_hyoji: string -> string -> string *)
let kyori_wo_hyoji eki1 eki2 = 
  let kanji1 = romaji_to_kanji eki1 global_ekimei_list in
    if kanji1 = "" 
      then eki1 ^ "という駅は存在しません"
      else let kanji2 = romaji_to_kanji eki2 global_ekimei_list in
        if kanji2 = ""
          then eki2 ^ "という駅は存在しません"
          else let kyori = get_ekikan_kyori kanji1 kanji2 global_ekikan_list in
          if kyori = max_float
            then kanji1 ^ "駅と" ^ kanji2 ^ "駅はつながっていません"
            else kanji1 ^ "駅から" ^ kanji2 ^ "駅までは" ^ string_of_float kyori ^ "kmです"

 (* test *)
 (* 
 #use "chapter10/kyori_wo_hyoji.ml";;
 *)
 let test1 = kyori_wo_hyoji "" "" = "という駅は存在しません"
 let test2 = kyori_wo_hyoji "myogadani" "hoge" = "hogeという駅は存在しません"
 let test3 = kyori_wo_hyoji "hoge" "myogadani" = "hogeという駅は存在しません"
 let test4 = kyori_wo_hyoji "kotakemukaihara" "hikawadai" = "小竹向原駅から氷川台駅までは1.5kmです"
 let test4 = kyori_wo_hyoji "kotakemukaihara" "heiwadai" = "小竹向原駅と平和台駅はつながっていません"
 