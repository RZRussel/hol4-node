open preamble
open ml_monad_translator_interfaceLib
open tProposalMsgTheory
open tExecutedBlockProgTheory (*previous*)
val _ = new_theory "tProposalMsgProg";
val _ = m_translation_extends "tExecutedBlockProg";
val _ = export_theory ();

