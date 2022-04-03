open preamble
open ml_monad_translator_interfaceLib
open tReactorTheory
open tFDInfoProgTheory (*previous*)
val _ = new_theory "tReactorProg";
val _ = m_translation_extends "tFDInfoProg";
val _ = export_theory ();

