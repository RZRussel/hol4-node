open preamble
open ml_monad_translator_interfaceLib
open tHashingTheory
open tAccountValidationProgTheory (*previous*)
val _ = new_theory "tHashingProg";
val _ = m_translation_extends "tAccountValidationProg";
val _ = export_theory ();

