(* eki_t型, ekimei_t型, global_ekimei_listのimport *)
#use "chapter12/prepare.ml"

(* appendのimport *)
#use "chapter10/append.ml"

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

(* 目的
直前に確定した駅p(eki_t型)と未確定の駅q(eki_t型)を受け取る
pとqが直接つながっているかを調べる
つながっていたらqの最短距離と手前リストを必要に応じて更新したものを返却
つながっていないならもとのqをそのまま返す
*)
(* koushin1: eki_t p -> eki_t q -> eki_t *)
let koushin1 p q = 
  let ekikan_kyori = get_ekikan_kyori p.namae q.namae global_ekikan_list
in
  if ekikan_kyori < q.saitan_kyori then {
    namae = q.namae;
    saitan_kyori = ekikan_kyori;
    temae_list = append [q.namae] p.temae_list
    }
  else q

(* test
# use "metro_network/code.ml";;
*)
let yoyogiuehara = {
  namae = "代々木上原"; saitan_kyori = max_float; temae_list = ["代々木上原"]
}
let yoyogikouen = {
  namae = "代々木公園"; saitan_kyori = max_float; temae_list = ["代々木公園"]
}
let meijijinguumae = {
  namae = "明治神宮前"; saitan_kyori = max_float; temae_list = ["明治神宮前"]
}

let test1 = koushin1 yoyogiuehara yoyogikouen = {
  namae = "代々木公園"; saitan_kyori = 1.0; temae_list = ["代々木公園"; "代々木上原"]
}
let test2 = koushin1 yoyogikouen yoyogiuehara = {
  namae = "代々木上原"; saitan_kyori = 1.0; temae_list = ["代々木上原"; "代々木公園"]
}
let test3 = koushin1 yoyogiuehara meijijinguumae = meijijinguumae

(* 目的: 
直前に確定した駅p(eki_t型)と未確定の駅のリストv(eki_t list型)を受け取る
必要な更新処理(koushin1)を行ったあと、未確定の駅のリストを返却する
*)
(* koushin: ('a -> 'b -> 'c) -> 'a -> 'b list -> 'c list *)
let rec koushin f p v = match v with
  [] -> []
  |first::rest -> f p first::koushin f p rest

(* test *)
let test4 = koushin koushin1 yoyogiuehara [yoyogikouen; meijijinguumae] = [
  {
  namae = "代々木公園"; saitan_kyori = 1.0; temae_list = ["代々木公園"; "代々木上原"]
  };
  meijijinguumae
]