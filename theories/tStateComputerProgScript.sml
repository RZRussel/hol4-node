open preamble
open ml_monad_translator_interfaceLib
open tStateComputerTheory
open tTxExecutionProgTheory (*previous*)
val _ = new_theory "tStateComputerProg";
val _ = m_translation_extends "tTxExecutionProg";
val _ = export_theory ();

