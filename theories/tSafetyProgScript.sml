open preamble
open ml_monad_translator_interfaceLib
open tSafetyTheory
open tUserKeyProgTheory (*previous*)
val _ = new_theory "tSafetyProg";
val _ = m_translation_extends "tUserKeyProg";
val _ = export_theory ();

