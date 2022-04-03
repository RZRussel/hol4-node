open preamble
open ml_monad_translator_interfaceLib
open tFDInfoTheory
open tEventHandlersProgTheory (*previous*)
val _ = new_theory "tFDInfoProg";
val _ = m_translation_extends "tEventHandlersProg";
val _ = export_theory ();

