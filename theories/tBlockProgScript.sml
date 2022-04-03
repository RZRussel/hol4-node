open preamble
open ml_monad_translator_interfaceLib
open tBlockTheory
open tBlockDataProgTheory (*previous*)
val _ = new_theory "tBlockProg";
val _ = m_translation_extends "tBlockDataProg";
val _ = export_theory ();

