open preamble
open ml_monad_translator_interfaceLib
open tStateTreeWriterTheory
open tStateTreeProgTheory (*previous*)
val _ = new_theory "tStateTreeWriterProg";
val _ = m_translation_extends "tStateTreeProg";
val _ = export_theory ();

