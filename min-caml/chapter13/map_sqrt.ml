(* 目的: 実数のリストlstを受け取り各要素の平方根のリストを返す *)
(* map_sqrt: float list -> float list *)
let rec map_sqrt lst = map sqrt lst


(* 目的: 関数fとリストlstを受け取りfを施したリストを返す *)
(* map: ('a -> 'b) -> 'a list -> 'b list *)
let rec map f lst = match lst with
  [] -> []
  |first::rest -> f first::map f rest


(* test
# use "chapter13/map_sqrt.ml";;
*)
let test1 = map_sqrt [] = []
let test2 = map_sqrt [4.0; 9.0] = [2.0; 3.0]

(* 目的: 関数を２つ受け取ったら、その２つの関数を合成した関数を返す *)
(* compose: ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b = <fun> *)
let compose x y = 
  let z a = x (y a)
  in z

let times2 x = x * 2
let add3 x = x + 3
let test3 = (compose times2 add3) 4 = 14

let twice f = 
  let g x = f (f x)
  in g