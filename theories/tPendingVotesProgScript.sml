open preamble
open ml_monad_translator_interfaceLib
open tPendingVotesTheory
open tSynchronizerProgTheory (*previous*)
val _ = new_theory "tPendingVotesProg";
val _ = m_translation_extends "tSynchronizerProg";
val _ = export_theory ();

