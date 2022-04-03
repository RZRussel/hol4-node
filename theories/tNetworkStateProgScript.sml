open preamble
open ml_monad_translator_interfaceLib
open tNetworkStateTheory
open tConnectedNodeSetProgTheory (*previous*)
val _ = new_theory "tNetworkStateProg";
val _ = m_translation_extends "tConnectedNodeSetProg";
val _ = export_theory ();

