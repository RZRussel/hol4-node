open preamble
open ml_monad_translator_interfaceLib
open tHashFunctionTheory
open tLoggerInitializersProgTheory (*previous*)
val _ = new_theory "tHashFunctionProg";
val _ = m_translation_extends "tLoggerInitializersProg";
val _ = export_theory ();

