open preamble
open ml_monad_translator_interfaceLib
open tTxExecutionUtilTheory
open tStateComputerNodeProgTheory (*previous*)
val _ = new_theory "tTxExeccutionUtilProg";
val _ = m_translation_extends "tStateComputerNodeProg";
val _ = export_theory ();

