(* gakusei_t型のimport *)
#use "chapter8/record.ml"

(* 目的: 学生リストlstのうち各成績の人数を集計する *)
(* shukei: gakusei_t list -> int * int * int * int *)
let rec shukei lst = match lst with
  [] -> (0, 0, 0, 0)
  | {namae = n; tensuu = t; seiseki = s}::rest ->
      let (a, b, c, d) =  shukei rest in
      if s = "A" then (a + 1 , b ,c, d)
      else if s = "B" then (a, b + 1, c, d)
      else if s = "C" then (a, b, c + 1, d)
      else (a, b, c, d + 1)


(* test *)
let test1 = shukei [{namae="asai"; tensuu=90; seiseki="A"}] = (1, 0, 0, 0)