open preamble
open ml_monad_translator_interfaceLib
open tEpollTheory
open tEpollEventProgTheory (*previous*)
val _ = new_theory "tEpollProg";
val _ = m_translation_extends "tEpollEventProg";
val _ = export_theory ();

