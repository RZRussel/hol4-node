open preamble
open ml_monad_translator_interfaceLib
open tTypeTheory
open tStateTreeWriterProgTheory (*previous*)
val _ = new_theory "tTypeProg";
val _ = m_translation_extends "tStateTreeWriterProg";
val _ = export_theory ();

