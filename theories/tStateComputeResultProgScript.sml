open preamble
open ml_monad_translator_interfaceLib
open tStateComputeResultTheory
open tBlockProgTheory (*previous*)
val _ = new_theory "tStateComputeResultProg";
val _ = m_translation_extends "tBlockProg";
val _ = export_theory ();

