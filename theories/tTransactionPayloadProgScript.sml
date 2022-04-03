open preamble
open ml_monad_translator_interfaceLib
open tTransactionPayloadTheory
open tAccountProgTheory (*previous*)
val _ = new_theory "tTransactionPayloadProg";
val _ = m_translation_extends "tAccountProg";
val _ = export_theory ();

