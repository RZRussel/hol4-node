open preamble
open ml_monad_translator_interfaceLib
open tTimerTheory
open tSocketProgTheory (*previous*)
val _ = new_theory "tTimerProg";
val _ = m_translation_extends "tSocketProg";
val _ = export_theory ();

