open preamble
open ml_monad_translator_interfaceLib
open tExecutedBlockTheory
open tStateComputeResultProgTheory (*previous*)
val _ = new_theory "tExecutedBlockProg";
val _ = m_translation_extends "tStateComputeResultProg";
val _ = export_theory ();

