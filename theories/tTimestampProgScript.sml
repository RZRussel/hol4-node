open preamble
open ml_monad_translator_interfaceLib
open tTimestampTheory
open tTimerProgTheory (*previous*)
val _ = new_theory "tTimestampProg";
val _ = m_translation_extends "tTimerProg";
val _ = export_theory ();

