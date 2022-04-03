open preamble
open ml_monad_translator_interfaceLib
open tErrnoTheory
open tFFICommonProgTheory (*previous*)
val _ = new_theory "tErrnoProg";
val _ = m_translation_extends "tFFICommonProg";
val _ = export_theory ();

