open preamble
open ml_monad_translator_interfaceLib
open tFdTheory
open tErrnoProgTheory (*previous*)
val _ = new_theory "tFdProg";
val _ = m_translation_extends "tErrnoProg";
val _ = export_theory ();

