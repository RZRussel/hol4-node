open preamble

open mlmapTheory

val _ = new_theory "tMap";

Definition Map__lookup_def:
  Map__lookup m k = mlmap$lookup m k
End

Definition Map__insert_def:
  Map__insert m k v = mlmap$insert m k v 
End

Definition Map__empty_def:
  Map__empty cmp = mlmap$empty cmp 
End

Definition Map__foldr_with_key_def:
  Map__foldr_with_key f x m = mlmap$foldrWithKey f x m
End

val _ = export_theory ();
