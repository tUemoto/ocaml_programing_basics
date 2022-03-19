#use "chapter15/quicksort.ml"
(* test
#use "chapter15/test.ml";;
*)
(* quicksortのテスト *)
let test1 = quick_sort [] = []
let test2 = quick_sort [1] = [1]
let test3 = quick_sort [1; 2] = [1; 2]
let test4 = quick_sort [2; 1] = [1; 2]
let test5 = quick_sort [5; 4; 9; 8; 2; 3] = [2; 3; 4; 5; 8; 9]
let test6 = quick_sort [5; 5; 4; 9; 8; 2; 3] = [2; 3; 4; 5; 5; 8; 9]

(* gcdのテスト *)
let test7 = gcd 0 0 = 0
let test8 = gcd 2 0 = 2
let test9 = gcd 12345 1234 = 1
let test10 = gcd 2048 3072 = 1024

(* sieveのテスト *)
let test11 = sieve [] = []
let test12 = sieve [2] = [2]
let test13 = sieve [2;3;4;5] = [2;3;5]

(* primeのテスト *)
let test14 = prime 0 = []
let test15 = prime 2 = [2]
let test16 = prime 5 = [2;3;5]