open preamble
open ml_monad_translator_interfaceLib
open tTransactionInfoTheory
open tTransactionPayloadProgTheory (*previous*)
val _ = new_theory "tTransactionInfoProg";
val _ = m_translation_extends "tTransactionPayloadProg";
val _ = export_theory ();

