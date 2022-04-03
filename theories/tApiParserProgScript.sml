open preamble
open ml_monad_translator_interfaceLib
open tApiParserTheory
open tRuntimeStateProgTheory (*previous*)
val _ = new_theory "tApiParserProg";
val _ = m_translation_extends "tRuntimeStateProg";
val _ = export_theory ();

