open preamble
open ml_monad_translator_interfaceLib
open tConcreteEventHandlersTheory
open tConcreteEventHandlerHelpersProgTheory (*previous*)
val _ = new_theory "tConcreteEventHandlersProg";
val _ = m_translation_extends "tConcreteEventHandlerHelpersProg";
val _ = export_theory ();

