open preamble
open ml_monad_translator_interfaceLib
open tAccountValidationTheory
open tComparatorsProgTheory (*previous*)
val _ = new_theory "tAccountValidationProg";
val _ = m_translation_extends "tComparatorsProg";
val _ = export_theory ();

