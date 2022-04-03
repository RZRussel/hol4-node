open preamble
open ml_monad_translator_interfaceLib
open tQuorumCertTheory
open tVoteProgTheory (*previous*)
val _ = new_theory "tQuorumCertProg";
val _ = m_translation_extends "tVoteProg";
val _ = export_theory ();

