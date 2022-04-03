open preamble
open ml_monad_translator_interfaceLib
open tStateTreeReaderTheory
open tStateNodeProgTheory (*previous*)
val _ = new_theory "tStateTreeReaderProg";
val _ = m_translation_extends "tStateNodeProg";
val _ = export_theory ();

