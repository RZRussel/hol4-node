open preamble
open ml_monad_translator_interfaceLib
open tStateTreeChangeTheory
open tStateKeyProgTheory (*previous*)
val _ = new_theory "tStateTreeChangeProg";
val _ = m_translation_extends "tStateKeyProg";
val _ = export_theory ();

