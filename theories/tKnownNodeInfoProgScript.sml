open preamble
open ml_monad_translator_interfaceLib
open tKnownNodeInfoTheory
open tHashingProgTheory (*previous*)
val _ = new_theory "tKnownNodeInfoProg";
val _ = m_translation_extends "tHashingProg";
val _ = export_theory ();

