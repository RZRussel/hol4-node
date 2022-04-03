open preamble
open ml_monad_translator_interfaceLib
open tBlockTreeTheory
open tStateComputerProgTheory (*previous*)
val _ = new_theory "tBlockTreeProg";
val _ = m_translation_extends "tStateComputerProg";
val _ = export_theory ();

