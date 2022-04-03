open preamble
open ml_monad_translator_interfaceLib
open tVoteTheory
open tVoteDataProgTheory (*previous*)
val _ = new_theory "tVoteProg";
val _ = m_translation_extends "tVoteDataProg";
val _ = export_theory ();

