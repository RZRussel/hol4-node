open preamble
open ml_monad_translator_interfaceLib
open tRunloopApiTheory
open tApiParserProgTheory (*previous*)
val _ = new_theory "tRunloopApiProg";
val _ = m_translation_extends "tApiParserProg";
val _ = export_theory ();


