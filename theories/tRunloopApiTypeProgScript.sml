open preamble
open ml_monad_translator_interfaceLib
open tRunloopApiTypeTheory
open tRunloopTypeProgTheory (*previous*)
val _ = new_theory "tRunloopApiTypeProg";
val _ = m_translation_extends "tRunloopTypeProg";
val _ = export_theory ();


