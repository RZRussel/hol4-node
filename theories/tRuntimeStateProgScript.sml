open preamble
open ml_monad_translator_interfaceLib
open tRuntimeStateTheory
open tRunloopApiTypeProgTheory (*previous*)
val _ = new_theory "tRuntimeStateProg";
val _ = m_translation_extends "tRunloopApiTypeProg";
val _ = export_theory ();

