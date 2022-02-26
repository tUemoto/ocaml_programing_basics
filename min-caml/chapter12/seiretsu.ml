(* ekimei_t型, global_ekimei_listのimport *)
#use "chapter9/metro.ml"

(* 
  目的: 予め昇順に並んでいる整数のリスト lstと整数nを受け取り、
  昇順となる位置にnを差し込んだリストを返す 
*)
(* insert: int list -> int -> int list *)
let rec insert lst n = match lst with
  [] -> [n]
  | first::rest -> 
    if first.kana == n.kana then lst
    else if first.kana < n.kana then first::(insert rest n)
    else n::lst

(* 
目的: ekimei_t型のリストlstを受け取って、ひらがなの順に整列し、
駅の重複を取り除いたekimei_t型のリストを返す
*)
(* seiretsu: elimei_t list -> ekimei_t list *)
let rec seiretsu lst = match lst with
  [] -> []
  |first::rest
    -> insert (seiretsu rest) first


(* test
# use "chapter12/seiretsu.ml";;
*)
let yoyogi = {kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"}
let meiji = {kanji="明治神宮前"; kana="めいじじんぐうまえ"; romaji="meijijinguumae"; shozoku="千代田線"}
let test1 = seiretsu [] = []
let test2 = seiretsu [yoyogi] = [yoyogi]
let test3 = seiretsu [yoyogi; meiji] = [meiji; yoyogi]
let test4 = seiretsu [yoyogi; yoyogi] = [yoyogi]
let test5 = seiretsu [yoyogi; meiji; meiji; yoyogi] = [meiji; yoyogi]