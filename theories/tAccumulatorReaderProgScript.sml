open preamble
open ml_monad_translator_interfaceLib
open tAccumulatorReaderTheory
open tTxAccumulatorProgTheory (*previous*)
val _ = new_theory "tAccumulatorReaderProg";
val _ = m_translation_extends "tTxAccumulatorProg";
val _ = export_theory ();

