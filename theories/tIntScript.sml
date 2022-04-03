open mlintTheory
open preamble
val _ = new_theory "tInt";

Definition Int__mod_def:
  Int__mod (x:int) (y:int) = x % y
End

Definition Int__div_def:
  Int__div (x:int) (y:int) = x / y
End

Definition Int__min_def:
  Int__min (x:int) (y:int) : int = if (x < y) then x else y
End

Definition Int__compare_def:
  Int__compare = mlint$int_cmp
End


val _ = export_theory ();


