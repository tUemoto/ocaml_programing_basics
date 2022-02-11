(* 目的: 昇順に並んでいるリストlst1とlst2をマージして昇順のint listを返す *)
(* merge: int list -> int list -> int list *)
let rec merge lst1 lst2 = match (lst1, lst2) with
(* ２つとも空なら空のlistを返す *)
  ([], []) -> []
(* lst1のみ空のケース *)
  |([], first2::rest2) -> lst2
(* lst2のみ空のケース *)
  |(first1::rest1, []) -> lst1
(* 両方空でないケース *)
  |(first1::rest1, first2::rest2) ->
    if first1 > first2
      then first2::merge lst1 rest2
      else first1::merge rest1 lst2

(* test *)
let test1 = merge [] [] = []
let test2 = merge [] [1; 2] = [1; 2]
let test3 = merge [1; 2] [] = [1; 2]
let test4 = merge [1; 4] [2; 3] = [1; 2; 3; 4]
let test5 = merge [4] [1; 2; 3; 4; 5] = [1; 2; 3; 4; 4; 5]