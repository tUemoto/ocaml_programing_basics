(* 駅名の情報を格納する型 *)
type ekimei_t = {
  kanji : string; (* 漢字名 *)
  kana : string; (* かな *)
  romaji : string; (* ローマ字 *)
  shozoku : string; (* 所属する路線名 *)
}

(* 目的: 駅の情報ekimeiを受け取り整形した文字列を返却する *)
(* hyoji: ekimei_t -> string *)
let hyoji ekimei = match ekimei with
  {kanji = kanji; kana = kana; shozoku = s} -> s ^ ", " ^ kanji ^ "（" ^ kana ^ "）"

(* test *)
let test1 = hyoji {kanji="茗荷谷"; kana="みょうがだに"; romaji="myogadani"; shozoku="丸ノ内線"}
  = "丸ノ内線, 茗荷谷（みょうがだに）"