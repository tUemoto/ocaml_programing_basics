(* ekimei_t型, global_ekimei_listのimport *)
#use "chapter9/metro.ml"

(* グラフの頂点の情報を格納する型 *)
type eki_t = {
  namae         : string; (* 駅名（漢字） *)
  saitan_kyori  : float; (* 駅名（漢字） *)
  temae_list    : string list; (* 駅名（漢字） *)
}

(* 目的: ekimei_t型のリストlstを受け取り、その駅名を利用してeki_t型のリストを返す *)
(* make_eki_list: ekimei_t list -> eki_t list *)
let rec make_eki_list lst = match lst with
  [] -> []
  | {kanji = kj; kana = kn; romaji = r; shozoku = s}::rest -> 
    {namae = kj; saitan_kyori = max_float; temae_list = []}:: make_eki_list rest


(* 
目的: グラフの頂点(eki_t型)のリストlstと指定の駅名nameを受け取り、
指定の駅名を起点として初期化したeki_t型のlistを返却する
*)
(* shokika: eki_t list -> string -> eki_t list *)
let rec shokika lst name = 
  if name = "" then lst
  else match lst with
    [] -> []
    |{namae = n; saitan_kyori = s; temae_list = t}::rest ->
      if n = name then {namae = n; saitan_kyori = 0.; temae_list = [n]}::rest
      else {namae = n; saitan_kyori = s; temae_list = t}::shokika rest name


(* 
# use "chapter12/prepare.ml";;
*)
(* test *)
let test1 = make_eki_list [] = []
let test2 = make_eki_list [
  {kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"}
  ] = [{namae="代々木上原"; saitan_kyori=max_float; temae_list=[]}]

(* ロジック *)
(* グラフの頂点のリストを定義 *)
let eki_list = make_eki_list global_ekimei_list
let initialized = shokika eki_list "赤坂"