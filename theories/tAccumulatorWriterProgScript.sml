open preamble
open ml_monad_translator_interfaceLib
open tAccumulatorWriterTheory
open tAccumulatorReaderProgTheory (*previous*)
val _ = new_theory "tAccumulatorWriterProg";
val _ = m_translation_extends "tAccumulatorReaderProg";
val _ = export_theory ();

