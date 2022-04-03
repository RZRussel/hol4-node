open preamble
open ml_monad_translator_interfaceLib
open tBigEndianTheory
open tSerializationProgTheory (*previous*)
val _ = new_theory "tBigEndianProg";
val _ = m_translation_extends "tSerializationProg";
val _ = export_theory ();

