(* 駅間の情報を格納する型 *)
type ekikan_t = {
  kiten : string; (* 起点の駅名 *)
  syuten : string; (* 終点の駅名 *)
  keiyu : string; (* 経由する路線名 *)
  kyori : float; (* 起点と終点の距離(km) *)
  jikan : int; (* 所要時間(minutes) *)
}

