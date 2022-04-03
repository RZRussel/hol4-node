open preamble
open ml_monad_translator_interfaceLib
open tRunloopTheory
open tConcreteEventHandlersProgTheory (*previous*)
val _ = new_theory "tRunloopProg";
val _ = m_translation_extends "tConcncreteEventHandlersProg";
val _ = export_theory ();

