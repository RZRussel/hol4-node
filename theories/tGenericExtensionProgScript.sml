open preamble
open ml_monad_translator_interfaceLib
open tGenericExtensionTheory
open tHexProgTheory (*previous*)
val _ = new_theory "tGenericExtensionProg";
val _ = m_translation_extends "tHexProg";
val _ = export_theory ();

