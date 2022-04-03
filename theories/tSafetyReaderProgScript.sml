open preamble
open ml_monad_translator_interfaceLib
open tSafetyReaderTheory
open tStorageProgTheory (*previous*)
val _ = new_theory "tSafetyReaderProg";
val _ = m_translation_extends "tStorageProg";
val _ = export_theory ();

