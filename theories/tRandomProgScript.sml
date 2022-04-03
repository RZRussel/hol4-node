open preamble
open ml_monad_translator_interfaceLib
open tRandomTheory
open tBigEndianProgTheory (*previous*)
val _ = new_theory "tRandomProg";
val _ = m_translation_extends "tBigEndianProg";
val _ = export_theory ();

