open preamble
open ml_monad_translator_interfaceLib
open tInitializeTheory
open tRunloopProgTheory (*previous*)
val _ = new_theory "tInitializeProg";
val _ = m_translation_extends "tRunloopProg";
val _ = export_theory ();

