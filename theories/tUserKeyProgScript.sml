open preamble
open ml_monad_translator_interfaceLib
open tUserKeyTheory
open tBlockGeneratorProgTheory (*previous*)
val _ = new_theory "tUserKeyProg";
val _ = m_translation_extends "tBlockGeneratorProg";
val _ = export_theory ();

