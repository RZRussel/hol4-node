open preamble
open ml_monad_translator_interfaceLib
open tEventHandlersTheory
open tIOProgTheory (*previous*)
val _ = new_theory "tEventHandlersProg";
val _ = m_translation_extends "tIOProg";
val _ = export_theory ();

