# use "chapter14/filter_positive.ml"
(* test
#use "chapter14/test.ml";;
*)
let test1 = filter_positive [0; 1; -4; 5; 9] = [1; 5; 9]
let test2 = sum [1;2;3;4;5] = 15
let test3 = length [1;1;1;1;1;1;1] = 7
let test4 = append [1; 2; 3; 4; 5] [1; 2;3] = [1; 2; 3; 4; 5; 1; 2; 3]
let test5 = enumerate 10 = [10; 9; 8; 7; 6; 5; 4; 3; 2; 1]
let test6 = divisor 6 = [6; 3; 2; 1]
(* let test7 = perfect 10000 = [8128; 496; 28; 6] *)
let test8 = one_to_n 10 = 55
let test9 = fact 6 = 720