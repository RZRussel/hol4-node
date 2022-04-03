open preamble
open ml_monad_translator_interfaceLib
open tPrettyStringTheory
open tContractProgTheory (*previous*)
val _ = new_theory "tPrettyStringProg";
val _ = m_translation_extends "tContractProg";
val _ = export_theory ();

