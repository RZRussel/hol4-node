open preamble
open ml_monad_translator_interfaceLib
open tLoggerLevelTheory
open tBufferProgTheory (*previous*)
val _ = new_theory "tLoggerLevelProg";
val _ = m_translation_extends "tBufferProg";
val _ = export_theory ();

