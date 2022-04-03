open preamble
open basis
open tWord8Theory
open tVectorProgTheory
open ml_monad_translator_interfaceLib

val _ = new_theory "tWord8Prog";
val _ = m_translation_extends "tVectorProg";

val fromInt_thm = translate Word8__fromInt_def;

val toInt_thm = translate Word8__toInt_def;

val andb_thm = translate Word8__andb_def;

val lshift_thm = translate Word8__lshift_def;

val _ = export_theory ();
