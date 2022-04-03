open preamble
open ml_monad_translator_interfaceLib
open tMainTheory
open tInitializeProgTheory (*previous*)
val _ = new_theory "tMainProg";
val _ = m_translation_extends "tInitializeProg";
val _ = export_theory ();

