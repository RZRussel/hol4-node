open preamble
open ml_monad_translator_interfaceLib

open tBoolProgTheory (*previous*)
open tListTheory

open mllistTheory
     
val _ = new_theory "tListProg";
val _ = m_translation_extends "tBoolProg";

val List__length_thm = translate List__length_def;
val List__take = translate List__take_def;

val List__unzip_thm  = translate List__unzip_def;
val List__zip_thm    = translate List__zip_def;

val List__takeUntil_thm = translate List__takeUntil_def;

val List__partition_aux_thm = translate List__partition_aux_def;
val List__partition_thm = translate List__partition_def;

val List__drop_thm = translate List__drop_def;

val _ = translate mllistTheory.foldl_aux_def;
val _ = translate mllistTheory.foldl_def;
val List__foldl_thm = translate List__foldl_def;

val List__map_thm = translate List__map_def;


val _ = export_theory ();

