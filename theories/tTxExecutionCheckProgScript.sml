open preamble
open ml_monad_translator_interfaceLib
open tTxExecutionCheckTheory
open tTxExecutionUtilProgTheory (*previous*)
val _ = new_theory "tTxExecutionCheckProg";
val _ = m_translation_extends "tTxExecutionUtilProg";
val _ = export_theory ();

