open preamble
open ml_monad_translator_interfaceLib
open tConnectionManagerTheory
open tMessageParserProgTheory (*previous*)
val _ = new_theory "tConnectionManagerProg";
val _ = m_translation_extends "tMessageParserProg";
val _ = export_theory ();

