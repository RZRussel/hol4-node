open preamble
open ml_monad_translator_interfaceLib
open tStateNodeTheory
open tStateTreeChangeProgTheory (*previous*)
val _ = new_theory "tStateNodeProg";
val _ = m_translation_extends "tStateTreeChangeProg";
val _ = export_theory ();

