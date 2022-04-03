open preamble
open basis
open tExceptionTheory
open tWord64ProgTheory (*previous*)
open ml_monad_translator_interfaceLib

val _ = new_theory "tExceptionProg";
val _ = m_translation_extends "tWord64Prog";

val _ = export_theory ();

