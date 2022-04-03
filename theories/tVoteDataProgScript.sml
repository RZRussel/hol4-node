open preamble
open ml_monad_translator_interfaceLib
open tVoteDataTheory
open tLedgerInfoProgTheory (*previous*)
val _ = new_theory "tVoteDataProg";
val _ = m_translation_extends "tLedgerInfoProg";
val _ = export_theory ();

