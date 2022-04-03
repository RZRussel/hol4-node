open preamble
open ml_monad_translator_interfaceLib
open tNodeDataSetTheory
open tKnownNodeInfoProgTheory (*previous*)
val _ = new_theory "tNodeDataSetProg";
val _ = m_translation_extends "tKnownNodeInfoProg";
val _ = export_theory ();

