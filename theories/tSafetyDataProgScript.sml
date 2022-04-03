open preamble
open ml_monad_translator_interfaceLib
open tSafetyDataTheory
open tVoteMsgProgTheory (*previous*)
val _ = new_theory "tSafetyDataProg";
val _ = m_translation_extends "tVoteMsgProg";
val _ = export_theory ();

