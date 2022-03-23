(* 距離と距離の合計を持っている型 *)
type distance_t = {
  kyori: float; (* 距離 *)
  total: float; (* 距離の合計 *)
}

(* 目的: 先頭からリスト中の各点までの距離の合計を計算する *)
(* total_distance: distance_t list -> distance_t list *)
let rec total_distance lst = 
  (* 目的: 先頭からリスト中の各店までの距離の合計を計算する *)
  (* ここでのtotal0はこれまでの距離の合計 *)
  (* hojo; distance_t list -> float -> distance_t list *)
  let rec hojo lst total0 = match lst with
    [] -> []
    |{kyori = k; total = t}::rest -> 
      {kyori = k; total = (total0 +. k)}::hojo rest (total0 +. k)
  in hojo lst 0.0

(* 目的: 与えられたリストを逆順にして返す *)
(* reverse: 'a list -> 'a list *)
let rec reverse lst =
  let rec hojo lst tmp = match lst with
    [] -> tmp
    |first::rest -> hojo rest (first::tmp)
  in hojo lst [] 

(* 目的: 関数fと初期値init、リストlstを受け取ったら
initから初めてリストの要素を左から順にfを施した結果を返す *)
(* fold_left: ('a -> 'b -> 'a) -> 'a  -> 'b list -> 'a *)
let rec fold_left f init lst = match lst with
  [] -> init
  |first::rest -> fold_left f (f init first) rest