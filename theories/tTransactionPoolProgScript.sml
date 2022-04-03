open preamble
open ml_monad_translator_interfaceLib
open tTransactionPoolTheory
open tValidatingProgTheory (*previous*)
val _ = new_theory "tTransactionPoolProg";
val _ = m_translation_extends "tValidatingProg";
val _ = export_theory ();

