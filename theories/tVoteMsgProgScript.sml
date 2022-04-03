open preamble
open ml_monad_translator_interfaceLib
open tVoteMsgTheory
open tProposalMsgProgTheory (*previous*)
val _ = new_theory "tVoteMsgProg";
val _ = m_translation_extends "tProposalMsgProg";
val _ = export_theory ();

