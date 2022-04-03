open preamble
open ml_monad_translator_interfaceLib
open tConnectedNodeInfoTheory
open tNodeDataSetProgTheory (*previous*)
val _ = new_theory "tConnectedNodeInfoProg";
val _ = m_translation_extends "tNodeDataSetProg";
val _ = export_theory ();

