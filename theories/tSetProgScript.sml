open preamble
open ml_monad_translator_interfaceLib

open tSetTheory
open tByteArrayProgTheory (*previous*)
val _ = new_theory "tSetProg";
val _ = m_translation_extends "tByteArrayProg";

val Set__member_thm = translate Set__member_def;
val Set__add_thm = translate Set__add_def;
val Set__empty_thm = translate Set__empty_def;
val Set__from_list_thm = translate Set__from_list_def;
val Set__to_list_thm = translate Set__to_list_def;

val _ = export_theory ();

