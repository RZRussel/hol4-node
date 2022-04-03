open preamble
open ml_monad_translator_interfaceLib
open tResultTheory
open tExceptionProgTheory (*previous*)
val _ = new_theory "tResultProg";
val _ = m_translation_extends "tExceptionProg";
val _ = export_theory ();

