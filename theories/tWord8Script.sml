
open preamble
val _ = new_theory "tWord8";

Definition Word8__fromInt_def:
  Word8__fromInt : int -> word8 = i2w
End

Definition Word8__toInt_def:
  Word8__toInt : word8 -> int = w2i
End

(*
Definition andb_def:
  Word8__andb = andb:word8->word8->word8
End
*)
Definition Word8__andb_def:
  Word8__andb (x:word8) (y:word8) : word8 = x && y
End

(* error:
Definition lshift_def:
  Word8__lshift (x:word8) (y:int) : word8 = x ≪  ((Num y):num)
End
  val lshift_thm = translate lshift_def;
  <-- "2nd arg to word shifts must be numeral constant"
It's not possible yet, use:
2^(x+y)
instead of
( Word8 (Word8.fromInt 1) (x+y) ).
 *)

(* temporary:
Definition Word8__lshift_def:
  Word8__lshift (x:word8) (y:int) : word8 = 0w
End
*)

Definition Word8__lshift_num_def:
  Word8__lshift_num (q:word8) (n:num) : word8 =
  case n of
    0 => q
  | SUC m => Word8__lshift_num (q << 1) m
End
open tIntTheory

val ERR = mk_HOL_ERR "Tactic"

fun USE_LAST_HYP (fu:term->tactic) : tactic =
  (fn x as (asl:term list, w:term) =>
  (case asl of
   he :: ta => fu he
   | _ => raise ERR "USE_LAST_HYP" "there are no hypotheses"
  ) x)

val FOR_ALL_HYP = REPEAT o USE_LAST_HYP

val UNDISCH_LAST = USE_LAST_HYP UNDISCH_TAC

val UNDISCH_ALL = FOR_ALL_HYP UNDISCH_TAC

Definition Word8__lshift_def:
  Word8__lshift (q:word8) (n:int) : word8 =
  case n of
    0i => q
  | n => if (n > 0) then
           Word8__lshift (q << 1) (n-1)
         else
           Word8__lshift (q >> 1) (n+1)
Termination
  WF_REL_TAC `measure (Num o ABS o (SND:word8 # int -> int) )` >>
  rw [] >>
  simp [integerTheory.NUM_LT] >>
  cheat
End
(* SKETCH OF PROOF
(*“(Num o ABS)”
“measure (Num o ABS)”
  WF_REL_TAC ‘measure (Num o ABS)’ >>
  exists_tac “λp. abs ()” >>
  qabbrev_tac `R = measure (\x. x)` >>
  qabbrev_tac `WG = measure (Num o ABS)` >>
  show_types := true
  exists_tac  ``measure (Num o ABS o (SND:word8 # int -> int) )`` >>
*)
(n' > 0) ==> ABS (n' - 1) < ABS n'
(n' < 0) ==> ABS (n' + 1) < ABS n'
simp [integerTheory.INT_ABS]
simp [integerTheory.INT_ABS_LT]
DISJ2_TAC >> (*irule boolTheory.OR_INTRO_THM2 >>*)
rw [integerTheory.INT_LT_NEGTOTAL] >>
`n' = (0 :int) ∨ (0 :int) < n' ∨ (0 :int) < -n'` by irule integerTheory.INT_LT_NEGTOTAL
rw [] >>
UNDISCH_ALL
simp [arithmeticTheory.NOT_GREATER] >>

rw [integerTheory.INT_NOT_GREATER] >>
integerTheory.INT_ABS_LT
*)


(* 
Word8.<< |--> Word8__lshift
*)

val _ = export_theory ();
