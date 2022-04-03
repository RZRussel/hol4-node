open preamble
open ml_monad_translator_interfaceLib
open tRuntimeTheory
open tPrettyStringProgTheory (*previous*)
val _ = new_theory "tRuntimeProg";
val _ = m_translation_extends "tPrettyStringProg";
val _ = export_theory ();

