open preamble
open ml_monad_translator_interfaceLib
open tConfigTheory
open tPublicKeyProgTheory (*previous*)
val _ = new_theory "tConfigProg";
val _ = m_translation_extends "tPublicKeyProg";
val _ = export_theory ();

