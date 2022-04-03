open std_preludeTheory
open preamble
val _ = new_theory "tVector";

Definition Vector__fromList_def:
  Vector__fromList = Vector
End

Definition Vector__toList_def:
  Vector__toList = mlvector$toList
End


Definition Vector__length_def:
  Vector__length (v:'a vector) : int = &((regexp_compiler$length v):num):int
End

(* the folllowing cannot be done: val vvector_CASE_thm = translate regexp_compilerTheory.vector_case_def;
Definition Vector__length_def:
  Vector__length (Vector a) = LENGTH a
End
*)

Definition Vector__collate_def:
  Vector__collate : ('a -> 'b -> ordering) -> 'a vector -> 'b vector -> ordering
    = mlvector$collate
End

Definition Vector__sub_def:
  Vector__sub v (i:int) = regexp_compiler$sub v (Num i)
End

Definition Vector__concat_def:
  Vector__concat : 'a vector list -> 'a vector = mlvector$concat
End

Definition Vector__tabulate_def:
  Vector__tabulate (x:int) (f:int->bool) = mlvector$tabulate (Num x) (λ(x:num). f &x)
End

val _ = export_theory ();
