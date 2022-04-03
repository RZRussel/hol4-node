open preamble
open ml_monad_translator_interfaceLib
open tPublicKeyTheory
open tNoiseProgTheory (*previous*)
val _ = new_theory "tPublicKeyProg";
val _ = m_translation_extends "tNoiseProg";
val _ = export_theory ();

