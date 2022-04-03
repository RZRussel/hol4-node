open preamble
open ml_monad_translator_interfaceLib
open tComputedStateTheory
open tRuntimeProgTheory (*previous*)
val _ = new_theory "tComputedStateProg";
val _ = m_translation_extends "tRuntimeProg";
val _ = export_theory ();

