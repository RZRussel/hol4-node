open preamble
open ml_monad_translator_interfaceLib
open tCodingTheory
open tTypeProgTheory (*previous*)
val _ = new_theory "tCodingProg";
val _ = m_translation_extends "TypetProg";
val _ = export_theory ();

