open preamble
open ml_monad_translator_interfaceLib
open tSynchronizerTheory
open tSafetyProgTheory (*previous*)
val _ = new_theory "tSynchronizerProg";
val _ = m_translation_extends "tSafetyProg";
val _ = export_theory ();

