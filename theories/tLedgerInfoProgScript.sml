open preamble
open ml_monad_translator_interfaceLib
open tLedgerInfoTheory
open tBlockInfoProgTheory (*previous*)
val _ = new_theory "tLedgerInfoProg";
val _ = m_translation_extends "tBlockInfoProg";
val _ = export_theory ();

