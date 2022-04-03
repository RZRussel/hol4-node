open preamble
open ml_monad_translator_interfaceLib
open tLoggerInitializersTheory
open tLoggerProgTheory (*previous*)
val _ = new_theory "tLoggerInitializersProg";
val _ = m_translation_extends "tLoggerProg";
val _ = export_theory ();

