open preamble
open ml_monad_translator_interfaceLib
open tAccountTheory
open tSyncInfoProgTheory (*previous*)
val _ = new_theory "tAccountProg";
val _ = m_translation_extends "tSyncInfoProg";
val _ = export_theory ();

