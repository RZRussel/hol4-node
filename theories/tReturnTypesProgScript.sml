open preamble
open ml_monad_translator_interfaceLib
open tReturnTypesTheory
open tTimerDataProgTheory (*previous*)
val _ = new_theory "tReturnTypesProg";
val _ = m_translation_extends "tTimerDataProg";
val _ = export_theory ();

