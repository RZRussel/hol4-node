open preamble
open ml_monad_translator_interfaceLib
open tMathTheory
open tGenericExtensionProgTheory (*previous*)
val _ = new_theory "tMathProg";
val _ = m_translation_extends "tGenericExtensionProg";
val _ = export_theory ();

