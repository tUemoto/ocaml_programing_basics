(* 
  目的: 予め昇順に並んでいる整数のリスト lstと整数nを受け取り、
  昇順となる位置にnを差し込んだリストを返す 
*)
(* insert: int list -> int -> int list *)
let rec insert lst n = match lst with
  [] -> [n]
  | first::rest -> if first < n then first::(insert rest n)
                                else n::lst

(* 目的: 整数のリストlstを受け取り昇順に並び替えたリストを返却する *)
(* ins_sort: int list -> int list *)
let rec ins_sort lst = match lst with
  [] -> []
  | first::rest -> insert (ins_sort rest) first


(* test *)
let test1 = insert [] 5 = [5]
let test2 = insert [1; 3; 4; 7; 8] 5 = [1; 3; 4; 5; 7; 8]
let test3 = insert [1; 3; 4; 7; 8] 0 = [0; 1; 3; 4; 7; 8]
let test4 = insert [1; 3; 4; 7; 8] 4 = [1; 3; 4; 4; 7; 8]

(* test *)
let test5 = ins_sort [] = []
let test6 = ins_sort [4] = [4]
let test7 = ins_sort [1; 3] = [1; 3]
let test8 = ins_sort [3; 1] = [1; 3]
let test9 = ins_sort [3; 1; 1] = [1; 1; 3]
let test10 = ins_sort [5; 3; 8; 1; 7; 4] = [1; 3; 4; 5; 7; 8]