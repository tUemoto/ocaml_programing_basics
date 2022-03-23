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

(* 目的: 
直前に確定した駅p(eki_t型)と未確定の駅のリストv(eki_t list型)を受け取る
必要な更新処理(koushin1)を行ったあと、未確定の駅のリストを返却する
*)
(* koushin: ('a -> 'b -> 'c) -> 'a -> 'b list -> 'c list *)
let rec koushin f p v = match v with
  [] -> []
  |first::rest -> f p first::koushin f p rest

(* 目的: eki_t list型のリストlstを受け取り、「最短距離最小の駅」「最短距離最小の駅以外からなるリスト」を返却する *)
(* saitan_wo_bunri: eki_t list ->  eki_t * eki_t list*)
let rec saitan_wo_bunri lst = match lst with
  [] -> ({namae = "error"; saitan_kyori = max_float; temae_list = []}, [])
  |first::rest -> List.fold_right (
    fun first (p, v) -> if first.saitan_kyori < p.saitan_kyori
      then (first, p::v)
      else (p, first::v)
    ) rest (first, [])


(* 以下fold_rightを使わない書き方 *)
(* let rec saitan_wo_bunri lst = match lst with
  [] -> ({namae = "error"; saitan_kyori = max_float; temae_list = []}, [])
  |first::[] -> (first, [])
  |first::rest -> let (saitan_rest, extracted) = saitan_wo_bunri rest
  in if first.saitan_kyori < saitan_rest.saitan_kyori
    then (first, saitan_rest::extracted)
    else (saitan_rest, first::extracted) *)

(* 目的:
直前に確定した駅p(eki_t型)と未確定の駅のリストv(eki_t list型)を受け取る
必要な更新処理(koushin1)を行ったあと、未確定の駅のリストを返却する
その際、利用する駅間リストを指定できるようにする
（koushinの改造版）
 *)
 (* koushin_kai: eki_t -> eki_t list -> ekikan_t list -> eki_t list *)
 let rec koushin_kai p v ekikan_list = match p with
    {namae = pn; saitan_kyori = pk; temae_list = pt} ->
      List.map (fun q -> match q with
        {namae = qn; saitan_kyori = qk; temae_list = qt} -> 
          let ekikan_kyori = get_ekikan_kyori pn qn ekikan_list
          in
            if ekikan_kyori +. pk < qk then {
              namae = qn;
              saitan_kyori = ekikan_kyori +. pk;
              temae_list = append [qn] pt
              }
            else q
        ) v

(* 目的: eki_t list型の(未確定の)駅のリストとekikan_t list型の駅間リストを受け取り
ダイクストラのアルゴリズムにしたがって各駅についての最短距離と最短経路が正しく入ったリスト(eki_t list)を返す
*)
(* dijkstra_main: eki_t list -> ekikan_t list -> eki_t list *)
let rec dijkstra_main eki_t_list ekikan_t_list = match eki_t_list with
  [] -> []
  |first::rest -> 
    let (saitan, nokori) = saitan_wo_bunri(eki_t_list)
    in
      let updated = koushin_kai saitan nokori ekikan_t_list
      in
        saitan::dijkstra_main updated ekikan_t_list

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


(* 目的：ekimei list から eki list を作る *) 
(* make_initial_eki_list : ekimei_t list -> string -> eki_t list *) 
let make_initial_eki_list ekimei_list kiten = 
  List.map (fun ekimei -> match ekimei with 
	     {kanji = k; kana = a; romaji = r; shozoku = s} -> 
	       if k = kiten 
	       then {namae = k; saitan_kyori = 0.; temae_list = [k]} 
	       else {namae = k; saitan_kyori = infinity; temae_list = []}) 
	   ekimei_list 
 
(* 目的：受け取った eki_list から shuten のレコードを探し出す *) 
(* find : string -> eki_t list -> eki_t *) 
let rec find shuten eki_list = match eki_list with 
  [] -> {namae = ""; saitan_kyori = infinity; temae_list = []} 
  | ({namae = n; saitan_kyori = s; temae_list = t} as first)::rest -> 
      if n = shuten then first else find shuten rest 

(* 目的:
始点と終点のローマ字を引数に取り、2駅間の最短距離を返却する
 *)
(* dijkstra: string -> string -> eki_t *)
let rec dijkstra shiten shuten = 
  let shiten_kanji = romaji_to_kanji shiten global_ekimei_list
  in let shuten_kanji = romaji_to_kanji shuten global_ekimei_list
  in let eki_list = make_initial_eki_list global_ekimei_list shiten_kanji
  in let calculated = dijkstra_main eki_list global_ekikan_list
  in find shuten_kanji calculated
