open preamble
open ml_monad_translator_interfaceLib
open tNetworkDataTheory
open tNetworkStateProgTheory (*previous*)
val _ = new_theory "tNetworkDataProg";
val _ = m_translation_extends "tNetworkStateProg";
val _ = export_theory ();

