(* 年号を表す型 *)
type seireki_t = 
  Meiji of int
  | Taisho of int
  | Showa of int
  | Heisei of int
  | Reiwa of int

(* 目的: 年号を受け取ったら対応する西暦年を返す *)
(* to_seireki: nengou_t -> int *)
let to_seireki nengou = match nengou with
  Meiji (n) -> 1867 + n
  |Taisho (n) -> 1911 + n
  |Showa (n) -> 1925 + n
  |Heisei (n) -> 1988 + n
  |Reiwa (n) -> 2018 + n

(* 木を表す型 *)
type tree_t = 
  Empty                             (* 空の木 *)
  | Leaf of int                     (* 葉 *)
  | Node of tree_t * int * tree_t   (* 節 *)

(* 
  treeは下記の値を取りうる
    - Empty     空の木
    - Leaf (n)  値がnの葉
    - Node (t1, n, t2)  左の木がt1, 値がn, 右の木がt2であるような節（t1とt2が自己参照）
*)

(* 木の例 *)
let tree1 = Empty
let tree2 = Leaf (3)
let tree3 = Node (tree1, 4, tree2)
let tree4 = Node (tree2, 5, tree3)

(* 目的: treeに含まれる整数をすべて加える *)
(* sum_tree: tree_t -> int *)
let rec sum_tree tree = match tree with
  Empty -> 0
  |Leaf (n) -> n
  |Node (t1, n, t2) -> n + sum_tree t1 + sum_tree t2

(* 目的: treeに含まれる整数をすべて2倍にする *)
(* tree_double: tree_t -> tree_t *)
let rec tree_double tree = match tree with
  Empty -> Empty
  |Leaf (n) -> Leaf (2 * n)
  |Node (t1, n, t2) -> Node (tree_double t1, 2 * n, tree_double t2)

(* 目的: int -> int型の関数fとtree_t型の木を受け取り、
節や葉に入っているすべての整数にfを適用した木を返す *)
(* tree_map: (int -> int) -> tree_t -> tree_t *)
let rec tree_map f tree = match tree with
  Empty -> Empty
  |Leaf (n) -> Leaf (f n)
  |Node (t1, n, t2) -> Node (tree_map f t1, f n, tree_map f t2)

(* 目的: tree_t型の木を受け取ったら木の深さを返す *)
(* tree_depth: tree_t -> int *)
let rec tree_depth tree = match tree with
  Empty -> 0
  |Leaf (n) -> 0
  |Node (t1, n, t2) -> 1 + max (tree_depth t1) (tree_depth t2)