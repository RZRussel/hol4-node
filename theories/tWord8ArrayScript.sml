open preamble
val _ = new_theory "tWord8Array";

val _ = type_abbrev("Word8Array", ``:word8 list``);

Definition Word8Array__array_def:
  Word8Array__array (l:int) (w:word8) = list$GENLIST (λ_.w) (Num l)
End

Definition Word8Array__length_def:
  Word8Array__length:Word8Array->int = λx. &(list$LENGTH x)
End

Definition Word8Array__sub_def:
  Word8Array__sub (x:Word8Array) (n:int) = list$EL (Num n) x
End
(* todo: check https://github.com/CakeML/cakeml/blob/master/basis/Word8ArrayProgScript.sml *)

Definition Word8Array__update_index_def:
  Word8Array__update_index ((h::tail):word8 list) (index:int) (position:int) (x:word8) :word8 list =
        if index = position then (x::tail)
        else h::(Word8Array__update_index tail (index+1) position x)
End
   
Definition Word8Array__update_def:
  Word8Array__update (arr:word8 list) i x =
    Word8Array__update_index arr i 0 x
End
val _ = export_theory ();
