open preamble
open ml_monad_translator_interfaceLib
open tSyncInfoTheory
open tQuorumCertProgTheory (*previous*)
val _ = new_theory "tSyncInfoProg";
val _ = m_translation_extends "tQuorumCertProg";
val _ = export_theory ();

