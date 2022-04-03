open preamble
open ml_monad_translator_interfaceLib
open tBlockDataTheory
open tSignedTransactionProgTheory (*previous*)
val _ = new_theory "tBlockDataProg";
val _ = m_translation_extends "tSignedTransactionProg";
val _ = export_theory ();

