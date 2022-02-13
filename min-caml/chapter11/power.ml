(* 目的: 自然数m, nを引数に取り、mのn乗の結果を返す *)
(* power: int m -> int n -> int *)
let rec power m n = 
  if n = 0 then 1
  else m * power m (n - 1)

(* test *)
(* 
#use "chapter11/power.ml";;
*)

let test1 = power 0 0 = 1
let test2 = power 0 1 = 0
let test3 = power 2 1 = 2
let test4 = power 3 3 = 27