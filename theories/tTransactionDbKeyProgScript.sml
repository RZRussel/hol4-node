open preamble
open ml_monad_translator_interfaceLib
open tTransactionDbKeyTheory
open tAccumulatorWriterProgTheory (*previous*)
val _ = new_theory "tTransactionDbKeyProg";
val _ = m_translation_extends "tAccumulatorWriterProg";
val _ = export_theory ();

