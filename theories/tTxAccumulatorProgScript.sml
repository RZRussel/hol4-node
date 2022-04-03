open preamble
open ml_monad_translator_interfaceLib
open tTxAccumulatorTheory
open tSafetyWriterProgTheory (*previous*)
val _ = new_theory "tTxAccumulatorProg";
val _ = m_translation_extends "tSafetyWriterProg";
val _ = export_theory ();

