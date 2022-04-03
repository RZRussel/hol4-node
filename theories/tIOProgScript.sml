open preamble
open ml_monad_translator_interfaceLib
open tIOTheory
open tTimeProgTheory (*previous*)
val _ = new_theory "tIOProg";
val _ = m_translation_extends "tTimeProg";
val _ = export_theory ();

