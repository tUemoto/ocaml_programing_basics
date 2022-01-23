(* 目的: 現在の気温tから快適度を表す文字列を計算する *)
(* kion: int -> string *)
let kion t = 
  if kaiteki t then "快適"
  else "普通"

(* 目的: 現在の気温tが15異常25以下かどうかをチェックする *)
(* kaiteki: int -> bool *)
let kaiteki t = 15 <= t && t <= 25

(* test: kion *)
let test1 = kion 7 = "普通"
let test2 = kion 15 = "快適"
let test3 = kion 20 = "快適"
let test4 = kion 25 = "快適"
let test5 = kion 28 = "普通"

(* test: kaiteki *)
let test_kaiteki1 = kaiteki 7 = false
let test_kaiteki2 = kaiteki 15 = true
let test_kaiteki3 = kaiteki 20 = true
let test_kaiteki4 = kaiteki 25 = true
let test_kaiteki5 = kaiteki 28 = false
