open preamble
open ml_monad_translator_interfaceLib
open tRoundStateTheory
open tPendingVotesProgTheory (*previous*)
val _ = new_theory "tRoundStateProg";
val _ = m_translation_extends "tPendingVotesProg";
val _ = export_theory ();

