open preamble
open ml_monad_translator_interfaceLib
open tArgpTheory
open tNetworkAddressProgTheory (*previous*)
val _ = new_theory "tArgpProg";
val _ = m_translation_extends "tNetworkAddressProg";
val _ = export_theory ();

