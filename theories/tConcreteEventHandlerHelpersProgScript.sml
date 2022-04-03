open preamble
open ml_monad_translator_interfaceLib
open tConcreteEventHandlerHelpersTheory
open tRunloopApiProgTheory (*previous*)
val _ = new_theory "tConcreteEventHandlerHelpersProg";
val _ = m_translation_extends "tRunloopApiProg";
val _ = export_theory ();

