
let rec filter p lst = match lst with
    [] -> []
    | first::rest ->
      if p first then first::filter p rest
      else filter p rest

let is_positive num = num > 0

(* 目的: 受け取ったリスト lstから正の要素のみ取り出す *)
(* filter_positive: int list -> int list *)
let rec filter_positive lst = filter is_positive lst




(* 目的: initから始めて、lstの要素を右から順にfを施す *)
(* fold_right: ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b *)
let rec fold_right f lst init = match lst with
  [] -> init
  | first::rest -> f first (fold_right f rest init)

(* 目的: 受け取ったリストlstの各要素の和を求める *)
(* sum: int list -> int *)
let sum lst = fold_right (+) lst 0


(* 目的: 受け取ったリストlstの長さを求める *)
(* length: 'a list -> int *)
let length lst = fold_right (fun first rest_result -> 1 +rest_result) lst 0



(* 目的: lst1とlst2を受け取りそれらを結合したリストを返す *)
(* append: 'a list -> 'a list -> 'a list *)
let append lst1 lst2 = 
  (* 目的: firstをリストrest_resultの先頭に加える *)
  (* cons: 'a -> 'a list -> 'a list *)
  let cons first rest_result = first::rest_result
  in fold_right cons lst1 lst2

(* 目的: nから1までのリストを作る *)
(* enumerate: int -> int list *)
let rec enumerate num =
  if num = 0 then [] else num::enumerate (num - 1)

(* 目的: 整数nの約数のリストを返す *)
(* divisor: int -> int list *)
let divisor num = filter (fun x -> num mod x = 0) (enumerate num)

(* 目的: 整数m以下の完全数のリストを返す *)
(* perfect: int -> int list *)
let perfect m = 
  filter (fun n -> fold_right (+) (divisor n) 0 - n = n) (enumerate m)

(* 目的: 1からnまでの自然数の和を返す *)
(* one_to_n: int -> int *)
let one_to_n n = fold_right (+) (enumerate n) 0

(* 目的: nの階乗を求める *)
(* fac: int -> int *)
let fact n = fold_right ( * ) (enumerate n) 1

(* test
#use "chapter14/filter_positive.ml";;
*)
let test1 = filter_positive [0; 1; -4; 5; 9] = [1; 5; 9]
let test2 = sum [1;2;3;4;5] = 15
let test3 = length [1;1;1;1;1;1;1] = 7
let test4 = append [1; 2; 3; 4; 5] [1; 2;3] = [1; 2; 3; 4; 5; 1; 2; 3]
let test5 = enumerate 10 = [10; 9; 8; 7; 6; 5; 4; 3; 2; 1]
let test6 = divisor 6 = [6; 3; 2; 1]
let test7 = perfect 10000 = [8128; 496; 28; 6]
let test8 = one_to_n 10 = 55
let test9 = fact 6 = 720