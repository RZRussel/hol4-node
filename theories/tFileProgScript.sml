open preamble
open ml_monad_translator_interfaceLib
open tFileTheory
open tTimestampProgTheory (*previous*)
val _ = new_theory "tFileProg";
val _ = m_translation_extends "tTimestampProg";
val _ = export_theory ();

