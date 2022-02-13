(* 目的: 0または自然数numを引数にとり、その階乗を結果として返す *)
(* fac: int num -> int *)
let rec fac num = 
  if num = 0
    then 1
    else num * fac (num - 1)

(* test *)
(* 
#use "chapter11/factorial.ml";;
*)
let test1 = fac 0 = 1
let test2 = fac 1 = 1
let test3 = fac 2 = 2
let test4 = fac 3 = 6
let test5 = fac 4 = 24
let test6 = fac 10 = 3628800
