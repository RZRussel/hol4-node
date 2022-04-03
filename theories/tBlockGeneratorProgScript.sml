open preamble
open ml_monad_translator_interfaceLib
open tBlockGeneratorTheory
open tTransactionPoolProgTheory (*previous*)
val _ = new_theory "tBlockGeneratorProg";
val _ = m_translation_extends "tTransactionPoolProg";
val _ = export_theory ();

