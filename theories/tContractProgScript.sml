open preamble
open ml_monad_translator_interfaceLib
open tContractTheory
open tErrorProgTheory (*previous*)
val _ = new_theory "tContractProg";
val _ = m_translation_extends "tErrorProg";
val _ = export_theory ();

