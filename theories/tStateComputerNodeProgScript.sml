open preamble
open ml_monad_translator_interfaceLib
open tStateComputerNodeTheory
open tComputedStateProgTheory (*previous*)
val _ = new_theory "tStateComputerNodeProg";
val _ = m_translation_extends "tComputedStateProg";
val _ = export_theory ();

