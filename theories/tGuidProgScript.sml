open preamble
open ml_monad_translator_interfaceLib
open tGuidTheory
open tRandomProgTheory (*previous*)
val _ = new_theory "tGuidProg";
val _ = m_translation_extends "tRandomProg";
val _ = export_theory ();

