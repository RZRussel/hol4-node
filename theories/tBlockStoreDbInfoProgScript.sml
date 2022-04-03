open preamble
open ml_monad_translator_interfaceLib
open tBlockStoreDbInfoTheory
open tBlockTreeProgTheory (*previous*)
val _ = new_theory "tBlockStoreDbInfoProg";
val _ = m_translation_extends "tBlockTreeProg";
val _ = export_theory ();

