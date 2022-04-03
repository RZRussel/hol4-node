open preamble
open ml_monad_translator_interfaceLib
open tValidatingTheory
open tTxValidationProgTheory (*previous*)
val _ = new_theory "tValidatingProg";
val _ = m_translation_extends "tTxValidationProg";
val _ = export_theory ();

