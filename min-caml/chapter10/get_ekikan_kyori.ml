(* ekimei_t型, global_ekimei_listのimport *)
#use "chapter9/metro.ml"

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

 (* test *)
 let test1 = get_ekikan_kyori "" "" [] = max_float
 let test2 = get_ekikan_kyori "" "" global_ekikan_list = max_float
 let test3 = get_ekikan_kyori "小竹向原" "氷川台" global_ekikan_list = 1.5
 let test4 = get_ekikan_kyori "氷川台" "小竹向原" global_ekikan_list = 1.5