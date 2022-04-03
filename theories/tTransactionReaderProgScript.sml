open preamble
open ml_monad_translator_interfaceLib
open tTransactionReaderTheory
open tTransactionDbKeyProgTheory (*previous*)
val _ = new_theory "tTransactionReaderProg";
val _ = m_translation_extends "tTransactionDbKeyProg";
val _ = export_theory ();

