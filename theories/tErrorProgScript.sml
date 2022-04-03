open preamble
open ml_monad_translator_interfaceLib
open tErrorTheory
open tCodingProgTheory (*previous*)
val _ = new_theory "tErrorProg";
val _ = m_translation_extends "tCodingProg";
val _ = export_theory ();

