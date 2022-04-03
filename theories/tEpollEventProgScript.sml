open preamble
open ml_monad_translator_interfaceLib
open tEpollEventTheory
open tEpollOpCodeProgTheory (*previous*)
val _ = new_theory "tEpollEventProg";
val _ = m_translation_extends "tEpollOpCodeProg";
val _ = export_theory ();

