open preamble
open ml_monad_translator_interfaceLib
open tTransactionWriterTheory
open tTransactionReaderProgTheory (*previous*)
val _ = new_theory "tTransactionWriterProg";
val _ = m_translation_extends "tTransactionReaderProg";
val _ = export_theory ();

