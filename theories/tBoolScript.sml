open preamble

val _ = new_theory "tBool";

Overload True = ``T``;
Overload False = ``F``;

(*
Definition Bool__True_def:
  Bool__True = T
End

Definition Bool__False_def:
  Bool__False = F
End
*)

Definition Bool__compare_def:
  Bool__compare x y = bool_cmp x y
End

val _ = export_theory ();

