open preamble
open ml_monad_translator_interfaceLib
open tTimerDataTheory
open tNetworkDataProgTheory (*previous*)
val _ = new_theory "tTimerDataProg";
val _ = m_translation_extends "tNetworkDataProg";
val _ = export_theory ();

