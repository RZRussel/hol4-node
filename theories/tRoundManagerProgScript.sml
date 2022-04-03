open preamble
open ml_monad_translator_interfaceLib
open tRoundManagerTheory
open tRoundStateProgTheory (*previous*)
val _ = new_theory "tRoundManagerProg";
val _ = m_translation_extends "tRoundStateProg";
val _ = export_theory ();

