open preamble
open ml_monad_translator_interfaceLib
open tNetworkAddressTheory
open tMathProgTheory (*previous*)
val _ = new_theory "tNetworkAddressProg";
val _ = m_translation_extends "tMathProg";
val _ = export_theory ();

