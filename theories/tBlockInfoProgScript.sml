open preamble
open ml_monad_translator_interfaceLib
open tBlockInfoTheory
open tConfigProgTheory (*previous*)
val _ = new_theory "tBlockInfoProg";
val _ = m_translation_extends "tConfigProg";
val _ = export_theory ();

