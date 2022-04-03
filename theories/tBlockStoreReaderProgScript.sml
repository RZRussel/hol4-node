open preamble
open ml_monad_translator_interfaceLib
open tBlocckStoreReaderTheory
open tBlockStoreDbInfoProgTheory (*previous*)
val _ = new_theory "tBlockStoreReaderProg";
val _ = m_translation_extends "tBlockStoreDbInfoProg";
val _ = export_theory ();

