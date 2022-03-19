#use "metro_network/code.ml"

(* test
# use "metro_network/test.ml";;
*)
let yoyogiuehara = {
  namae = "代々木上原"; saitan_kyori = max_float; temae_list = ["代々木上原"]
}
let yoyogikouen = {
  namae = "代々木公園"; saitan_kyori = max_float; temae_list = ["代々木公園"]
}
let meijijinguumae = {
  namae = "明治神宮前"; saitan_kyori = max_float; temae_list = ["明治神宮前"]
}

(* koushin1のテスト *)
let test1 = koushin1 yoyogiuehara yoyogikouen = {
  namae = "代々木公園"; saitan_kyori = 1.0; temae_list = ["代々木公園"; "代々木上原"]
}
let test2 = koushin1 yoyogikouen yoyogiuehara = {
  namae = "代々木上原"; saitan_kyori = 1.0; temae_list = ["代々木上原"; "代々木公園"]
}
let test3 = koushin1 yoyogiuehara meijijinguumae = meijijinguumae

(* kouhinのテスト *)
let test4 = koushin koushin1 yoyogiuehara [yoyogikouen; meijijinguumae] = [
  {
  namae = "代々木公園"; saitan_kyori = 1.0; temae_list = ["代々木公園"; "代々木上原"]
  };
  meijijinguumae
]