open preamble
open ml_monad_translator_interfaceLib
open tKeypairTheory
open tHashFunctionProgTheory (*previous*)
val _ = new_theory "tKeypairProg";
val _ = m_translation_extends "tHashFunctionProg";
val _ = export_theory ();

