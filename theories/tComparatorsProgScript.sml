open preamble
open ml_monad_translator_interfaceLib
open tComparatorsTheory
open tSafetyDataProgTheory (*previous*)
val _ = new_theory "tComparatorsProg";
val _ = m_translation_extends "tSafetyDataProg";
val _ = export_theory ();


