open preamble
open ml_monad_translator_interfaceLib
open tTxValidationTheory
open tBlockStoreProgTheory (*previous*)
val _ = new_theory "tTxValidationProg";
val _ = m_translation_extends "tBlockStoreProg";
val _ = export_theory ();


