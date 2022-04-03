open tIntTheory
open tOrderingProgTheory (*previous*)

open preamble
open basis
open ml_monad_translator_interfaceLib

val _ = new_theory "tIntProg";
val _ = m_translation_extends "tOrderingProg";

val Int__mod_thm = translate Int__mod_def;
val Int__div_thm = translate Int__div_def;
val Int__min_thm = translate Int__min_def;
val Int__compare_thm = translate Int__compare_def;

val _ = export_theory ();

