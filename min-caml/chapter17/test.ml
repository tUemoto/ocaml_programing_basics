#use "chapter17/to_seireki.ml"

(* test
#use "chapter17/test.ml";;
*)

(* to_seirekiのテスト *)
let test1 = to_seireki (Showa 20) = 1945
let test2 = to_seireki (Meiji 7) = 1874
let test3 = to_seireki (Taisho 0) = 1911
let test4 = to_seireki (Heisei 1) = 1989
let test5 = to_seireki (Reiwa 4) = 2022
let test6 = to_seireki (Heisei 34) = 2022

(* sum_treeのテスト *)
let test7 = sum_tree tree1 = 0
let test8 = sum_tree tree2 = 3
let test9 = sum_tree tree3 = 7
let test10 = sum_tree tree4 = 15

(* tree_doubleのテスト *)
let test11 = tree_double tree1 = Empty
let test12 = tree_double tree2 = Leaf (6)
let test13 = tree_double tree3 = Node (Empty, 8, Leaf (6))
let test14 = tree_double tree4 = Node (Leaf (6), 10, Node (Empty, 8, Leaf(6)))

(* tree_mapのテスト *)
let square num = if num = 0 then 1 else num * num
let test15 = tree_map square tree1 = Empty
let test16 = tree_map square tree2 = Leaf (9)
let test17 = tree_map square tree3 = Node (Empty, 16, Leaf(9))
let test18 = tree_map square tree4 = Node (Leaf (9), 25, Node (Empty, 16, Leaf (9)))

(* tree_depthのテスト *)
let test19 = tree_depth tree1 = 0
let test20 = tree_depth tree2 = 0
let test21 = tree_depth tree3 = 1
let test22 = tree_depth tree4 = 2