open tWord8ArrayTheory
open tWord8ProgTheory (*previous*)

open preamble
open basis
open ml_monad_translator_interfaceLib

val _ = new_theory "tWord8ArrayProg";
val _ = m_translation_extends "tWord8Prog";

(*val _ = type_abbrev("Word8Array", ``:word8 list``); *)

val SNOC_thm = translate listTheory.SNOC;
val GENLIST_thm = translate listTheory.GENLIST;
val array_thm = translate Word8Array__array_def;
(*val array_v_def = (definition "word8array__array_v_def");*)


(** ??? val llength_thm = translate listTheory.LENGTH; *)
val length_thm = translate Word8Array__length_def;
(** val length_v_def = (definition "word8array__length_v_def"); **)
(** val _ = ListProgTheory.length_v_def; **)


val lhd_thm = translate listTheory.HD;
(* val lhd_v_def = (definition "hd_1_v_def"); it is already exists as ListProgTheory.length_v_def *)
val ltl_thm = translate listTheory.TL;
val lel_thm = translate listTheory.EL;
(*val lel_v_def = (definition "length_v_def");*)
val Word8Array__sub_thm = translate Word8Array__sub_def;

(*val sub_v_def = (definition "sub_v_def");*)
(* todo: check https://github.com/CakeML/cakeml/blob/master/basis/Word8ArrayProgScript.sml *)

val _ = export_theory ();
