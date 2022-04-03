open preamble
open ml_monad_translator_interfaceLib
open tFFICommonTheory
open tMarshallingHelpProgTheory (*previous*)
val _ = new_theory "tFFICommonProg";
val _ = m_translation_extends "tMarshallingHelpProg";
val _ = export_theory ();

