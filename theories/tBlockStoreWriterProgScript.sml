open preamble
open ml_monad_translator_interfaceLib
open tBlockStoreWriterTheory
open tBlockStoreReaderProgTheory (*previous*)
val _ = new_theory "tBlockStoreWriterProg";
val _ = m_translation_extends "tBlockStoreReaderProg";
val _ = export_theory ();

