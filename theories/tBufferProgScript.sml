open preamble
open ml_monad_translator_interfaceLib
open tBufferTheory
open tArgpProgTheory (*previous*)
val _ = new_theory "tBufferProg";
val _ = m_translation_extends "tArgpProg";
val _ = export_theory ();

