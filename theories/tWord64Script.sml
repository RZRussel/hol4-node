open preamble
val _ = new_theory "tWord64";

Definition Word64__fromInt_def:
  Word64__fromInt : int -> word64 = i2w
End

Definition Word64__toInt_def:
  Word64__toInt : word64 -> int = w2i
End

(*Definition andb_def:
  Word64__andb = andb:word64->word64->word64
End
*)
Definition Word64__andb_def:
  Word64__andb (x:word64) (y:word64) : word64 = x && y
End

(* error:
Definition lshift_def:
  Word64__lshift (x:word64) (y:int) : word64 = x ≪  ((Num y):num)
End
  val lshift_thm = translate lshift_def;
  <-- "2nd arg to word shifts must be numeral constant"
It's not possible yet, use:
2^(x+y)
instead of
( Word64 (Word64.fromInt 1) (x+y) ).
 *)

(* temporary: *)
Definition Word64__lshift_def:
  Word64__lshift (x:word64) (y:int) : word64 = 0w
End

(* 
Word64.<< |--> Word64__lshift
*)

val _ = export_theory ();

