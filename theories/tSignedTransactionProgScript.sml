open preamble
open ml_monad_translator_interfaceLib
open tSignedTransactionTheory
open tTransactionInfoProgTheory (*previous*)
val _ = new_theory "tSignedTransactionProg";
val _ = m_translation_extends "tTransactionInfoProg";
val _ = export_theory ();

