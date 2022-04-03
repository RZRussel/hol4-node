open tMapTheory
open tStringProgTheory (*previous*)

open preamble
open basis
open ml_monad_translator_interfaceLib

val _ = new_theory "tMapProg";
val _ = m_translation_extends "tStringProg";

val Map__lookup_thm = translate Map__lookup_def;
val Map__insert_thm = translate Map__insert_def;
val Map__empty_thm = translate Map__empty_def;
val Map__foldr_with_key_thm = translate Map__foldr_with_key_def;

val _ = export_theory ();
