open preamble
open ml_monad_translator_interfaceLib
open tSafetyWriterTheory
open tSafetyReaderProgTheory (*previous*)
val _ = new_theory "tSafetyWriterProg";
val _ = m_translation_extends "tSafetyReaderProg";
val _ = export_theory ();

