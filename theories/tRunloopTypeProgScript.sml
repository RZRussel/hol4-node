open preamble
open ml_monad_translator_interfaceLib
open tRunloopTypeTheory
open tConnectionManagerProgTheory (*previous*)
val _ = new_theory "tRunloopTypeProg";
val _ = m_translation_extends "tConnectionManagerProg";
val _ = export_theory ();

