open preamble
open ml_monad_translator_interfaceLib
open tEpollOpCodeTheory
open tFdProgTheory (*previous*)
val _ = new_theory "tEpollOpCodeProg";
val _ = m_translation_extends "tFdProg";
val _ = export_theory ();

