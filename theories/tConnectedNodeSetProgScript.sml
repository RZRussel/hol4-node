open preamble
open ml_monad_translator_interfaceLib
open tConnectedNodeSetTheory
open tConnectedNodeInfoProgTheory (*previous*)
val _ = new_theory "tConnectedNodeSetProg";
val _ = m_translation_extends "tConnectedNodeInfoProg";
val _ = export_theory ();

