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

(* saitanのテスト *)
let eki_a = {namae = "test1"; saitan_kyori = 0.1; temae_list = ["test1"]}
let eki_b = {namae = "test2"; saitan_kyori = 0.2; temae_list = ["test2"]}
let eki_c = {namae = "test3"; saitan_kyori = 0.3; temae_list = ["test3"]}
let test5 = saitan_wo_bunri [eki_a; eki_b; eki_c] = (eki_a, [eki_b; eki_c])

(* koushin_kaiのテスト *)

(* 駅の例 *) 
let eki1 = {namae="池袋"; saitan_kyori = max_float; temae_list = []} 
let eki2 = {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]} 
let eki3 = {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]} 
let eki4 = {namae="後楽園"; saitan_kyori = max_float; temae_list = []} 
 
(* 駅リストの例 *) 
let lst = [eki1; eki2; eki3; eki4] 
 
(* テスト *) 
let test6 = koushin_kai eki2 [] global_ekikan_list = [] 
let test7 = koushin_kai eki2 lst global_ekikan_list = 
 [{namae="池袋"; saitan_kyori = 3.0; temae_list = ["池袋"; "新大塚"; "茗荷谷"]}; 
  eki2; eki3; eki4] 

(* dijkstra_mainのテスト *)
let test8 = dijkstra_main [] global_ekikan_list = [] 
let test9 = dijkstra_main lst global_ekikan_list = 
  [{namae = "茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]}; 
    {namae = "新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]}; 
    {namae = "後楽園"; saitan_kyori = 1.8; temae_list = ["後楽園"; "茗荷谷"]}; 
    {namae = "池袋"; saitan_kyori = 3.; temae_list = ["池袋"; "新大塚"; "茗荷谷"]}] 


(* dijkstraのテスト *)
let test10 = dijkstra "shibuya" "gokokuji" = 
  {namae = "護国寺"; saitan_kyori = 9.8; 
   temae_list = 
     ["護国寺"; "江戸川橋"; "飯田橋"; "市ヶ谷"; "麹町"; "永田町"; 
      "青山一丁目"; "表参道"; "渋谷"]} 
let test11 = dijkstra "myogadani" "meguro" = 
  {namae = "目黒"; saitan_kyori = 12.7000000000000028; 
   temae_list = 
     ["目黒"; "白金台"; "白金高輪"; "麻布十番"; "六本木一丁目"; "溜池山王"; 
      "永田町"; "麹町"; "市ヶ谷"; "飯田橋"; "後楽園"; "茗荷谷"]} 
