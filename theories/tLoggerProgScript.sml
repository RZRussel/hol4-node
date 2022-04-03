open preamble
open ml_monad_translator_interfaceLib
open tLoggerTheory
open tLoggerLevelProgTheory (*previous*)
val _ = new_theory "tLoggerProg";
val _ = m_translation_extends "tLoggerLevelProg";
val _ = export_theory ();

