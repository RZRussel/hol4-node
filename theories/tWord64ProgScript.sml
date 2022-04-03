open preamble
open basis
open tWord64Theory
open tMapProgTheory
open ml_monad_translator_interfaceLib

val _ = new_theory "tWord64Prog";
val _ = m_translation_extends "tMapProg";

val Word64_fromInt_thm = translate Word64__fromInt_def;

val Word64_toInt_thm = translate Word64__toInt_def;

val Word64_andb_thm = translate Word64__andb_def;

val Word64_lshift_thm = translate Word64__lshift_def;

val _ = export_theory ();

