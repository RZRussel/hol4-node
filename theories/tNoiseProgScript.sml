open preamble
open ml_monad_translator_interfaceLib
open tNoiseTheory
open tKeypairProgTheory (*previous*)
val _ = new_theory "tNoiseProg";
val _ = m_translation_extends "tKeypairProg";
val _ = export_theory ();

