open tMonadicTheory

open preamble
open basis
open ml_monad_translator_interfaceLib

val _ = new_theory "tMonadicProg";
val _ = m_translation_extends "tMonadic";

val _ = export_theory ();

