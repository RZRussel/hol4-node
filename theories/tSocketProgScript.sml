open preamble
open ml_monad_translator_interfaceLib
open tSocketTheory
open tEpollProgTheory (*previous*)
val _ = new_theory "tSocketProg";
val _ = m_translation_extends "tEpollProg";
val _ = export_theory ();

