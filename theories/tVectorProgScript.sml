open preamble
open basis

open std_preludeTheory
open tVectorTheory
open tListProgTheory
(*open ml_monad_translator_interfaceLib*)
open ml_monad_translatorLib
(*open ml_translatorTheory*)
open mlvectorTheory

val _ = new_theory "tVectorProg";
val _ = m_translation_extends "tListProg";

(* open basis *)
(* open mllistTheory*)

val Vector__fromList_thm = translate Vector__fromList_def;

val Vector__toList_thm = translate Vector__toList_def;

val Vector__length_thm = translate Vector__length_def;

(*val collate_thm = translate mlvectorTheory.collate_def;*)
val Vector__collate_thm = translate Vector__collate_def;

val Vector__sub_thm = translate Vector__sub_def;
(*mlvector$sub*)


val Vector__concat_thm = translate Vector__concat_def;

val Vector__tabulate_thm = translate Vector__tabulate_def;

(*
val st = get_ml_prog_state();

val fromList_v_def = fetch_v "fromlist" st;
val length_v_def = fetch_v "length_3" st;
*)

(*
val length_v_def = fetch_v "tVector$length" st ???
val fromList_v_def = (definition "fromlist_v_def");
val length_v_def = (definition "length_v_def");
fetch_v "convertW8Array2List" st
*)
 
val _ = export_theory ();

