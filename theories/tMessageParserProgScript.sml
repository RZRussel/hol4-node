open preamble
open ml_monad_translator_interfaceLib
open tMessageParserTheory
open tRoundManagerProgTheory (*previous*)
val _ = new_theory "tMessageParserProg";
val _ = m_translation_extends "tRoundManagerProg";
val _ = export_theory ();

