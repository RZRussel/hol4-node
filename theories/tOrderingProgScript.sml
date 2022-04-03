open preamble
open ml_monad_translator_interfaceLib
open tOrderingTheory
open tMonadicProgTheory (*previous*)
val _ = new_theory "tOrderingProg";
val _ = m_translation_extends "tMonadicProg";
val _ = export_theory ();

