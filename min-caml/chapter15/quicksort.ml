(* filterのimport *)
# use "chapter14/filter_positive.ml"


(* 目的: 受け取ったlstをクイックソートを使って昇順に整列する *)
(* quick_sort: int list -> int list *)
let rec quick_sort lst = 
  (* 目的: lstの中からnよりp(大きい/小さい)である要素のみ取り出す *)
  (* take: int -> int lst -> (int -> int -> bool) -> int lst *)
  let rec take n lst p = filter (fun item -> p item n) lst

  (* 目的: lstの中からnより小さい要素のみを取り出す *)
  (* take_less: int -> int list -> int list *)
  in let rec take_less n lst = take n lst (<=)

  (* 目的: lstの中からnより大きい要素のみを取り出す *)
  (* take_greater: int -> int list -> int list *)
  in let rec take_greater n lst = take n lst (>)
  in match lst with
  [] -> []
  |first::rest -> quick_sort (take_less first rest)
                @ [first]
                @ quick_sort (take_greater first rest)

(* 目的: 級数の第n項を求める *)
(* dai_n_kou: int -> float *)
let rec dai_n_kou n = 
  if n = 0
  then 1.0
  else dai_n_kou (n - 1) /. float_of_int n

(* 目的: 自然対数eの近似値を求める *)
(* e: int -> float *)
let rec e n =
  let d = dai_n_kou n 
  in if d < 0.00001
  then d
  else d +. e (n + 1)

(* 目的: 2つの自然数mとnの最大公約数をユークリッドの互除法を利用して求める(m >= n >= 0) *)
(* gcd: int -> int -> int *)
let rec gcd m n = 
  if n = 0 then m
  else gcd n (m mod n)


(* 目的: 自然数m, nを受け取り、mからnまでの降順の自然数のリストを返却する (m >= n >= 0) *)
(* create_int_list: int -> int -> int list *)
let rec create_int_list m n = 
  if n < 0 then create_int_list m 0
  else if m <= n then [m]
  else m::create_int_list (m - 1) n

(* 目的: 自然数mを受け取り、2からmまでの昇順の自然数のリストを返却する *)
(* create_2_list: int -> int list *)
let rec create_2_list m =
  let lst = create_int_list m 2
  in quick_sort lst

(* 目的: 2以上n以下の自然数のリストlstを受け取り、2以上n以下の素数のリストを返す *)
(* sieve: int list -> int list*)
let rec sieve lst = match lst with
  [] -> []
  | first::rest -> 
    let is_not_divisible m n = m mod n != 0 
    in let filtered = filter (fun item -> is_not_divisible item first) rest
    in first::sieve filtered

(* 目的: 自然数nを受け取りそれ以下の素数のリストを返す *)
(* prime: int -> int list *)
let rec prime n =
  if n < 2 then []
  else 
    let lst = create_2_list n
    in sieve lst