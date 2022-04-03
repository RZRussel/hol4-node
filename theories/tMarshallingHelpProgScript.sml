open preamble
open ml_monad_translator_interfaceLib
open tMarshallingHelpTheory
open tReturnTypesProgTheory (*previous*)
val _ = new_theory "tMarshallingHelpProg";
val _ = m_translation_extends "tReturnTypesProg";
val _ = export_theory ();

