(* 目的: 整数numと接頭語のリスト（int list）lstを受け取り各接頭語の先頭に整数を付け加える *)
(* add_to_each: int -> int list list ->int list list *)
let rec add_to_each num lst = match lst with
  [] -> []
  | first::rest -> (num::first):: add_to_each num rest

(* 目的: 受け取ったlstの接頭語のリストを求める *)
(* prefix: int list -> int list list*)
let rec prefix lst = match lst with
  [] -> []
  | first::rest -> [first]:: add_to_each first (prefix rest)

(* test *)
let test1 = add_to_each 1 [] = []
let test2 = add_to_each 1 [[2]] = [[1; 2]]
let test3 = add_to_each 1 [[2]; [2; 3]] = [[1; 2]; [1; 2; 3]]
let test4 = add_to_each 1 [[2]; [2; 3]; [2; 3; 4]] = [[1; 2]; [1; 2; 3]; [1; 2; 3; 4]]

(* test *)
let test5 = prefix [] = []
let test6 = prefix [1] = [[1]]
let test7 = prefix [1; 2] = [[1]; [1; 2]]
let test8 = prefix [1; 2; 3; 4] = [[1]; [1; 2]; [1; 2; 3]; [1; 2; 3; 4]]
