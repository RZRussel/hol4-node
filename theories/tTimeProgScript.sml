open preamble
open ml_monad_translator_interfaceLib
open tTimeTheory
open tFileProgTheory (*previous*)
val _ = new_theory "tTimeProg";
val _ = m_translation_extends "tFileProg";
val _ = export_theory ();

