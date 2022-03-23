#use "chapter16/accumulator.ml"

(* test
#use "chapter16/test.ml";;
 *)
(* total_distanceのテスト
浮動小数点を含むからか、結果が期待通りにならない。
 *)
(* let lst = [
  {kyori = 0.1; total = 0.0};
  {kyori = 0.2; total = 0.0};
  {kyori = 0.3; total = 0.0};
  {kyori = 0.4; total = 0.0};
  {kyori = 0.6; total = 0.0}
]
let expected = [
  {kyori = 0.1; total = 0.1};
  {kyori = 0.2; total = 0.3};
  {kyori = 0.3; total = 0.6};
  {kyori = 0.4; total = 1.0};
  {kyori = 0.6; total = 1.6}
]
let test1 = total_distance lst = expected *)

(* reverseのテスト *)
let test2 = reverse [1;2;3;4;5] = [5;4;3;2;1]

(* fold_leftのテスト *)
let test3 = fold_left (-) 0 [] = 0
let test4 = fold_left (-) 10 [1;2] = 7
let test5 = fold_left (fun lst a -> a::lst) [] [1;2;3;4] = [4;3;2;1]