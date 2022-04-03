open preamble
open ml_monad_translator_interfaceLib
open tQueryResultTheory
open tTxExecutionCheckProgTheory (*previous*)
val _ = new_theory "tQueryResultProg";
val _ = m_translation_extends "tTxExecutionCheckProg";
val _ = export_theory ();

