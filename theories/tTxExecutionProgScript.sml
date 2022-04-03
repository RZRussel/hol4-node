open preamble
open ml_monad_translator_interfaceLib
open tTxExecutionTheory
open tQueryResultProgTheory (*previous*)
val _ = new_theory "tTxExecutionProg";
val _ = m_translation_extends "tQueryResultProg";
val _ = export_theory ();

