open preamble
open ml_monad_translator_interfaceLib
open tBlockStoreTheory
open tBlockStoreWriterProgTheory (*previous*)
val _ = new_theory "tBlockStoreProg";
val _ = m_translation_extends "tBlockStoreWriterProg";
val _ = export_theory ();

