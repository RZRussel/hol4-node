open tStateTreeTheory
open tStateTreeReader (*previous*)
open tByteArrayTheory
open tByteArrayProgTheory
open tRawKeyProgTheory

open preamble
open basis
open ml_monad_translator_interfaceLib

val _ = new_theory "tStateTreeProg";
val _ = m_translation_extends "tStateTreeReaderProg"; (*!*)

val StateTreeReader__read_thm = translate StateTreeReader__read_def;

val StateTreeChange__compare_thm = translate StateTreeChange__compare_def;
val StateTreeChange__set_key_thm = translate StateTreeChange__set_key_def;
val StateTreeChange__set_account_thm = translate StateTreeChange__set_account_def;
val StateTreeChange__get_key_thm = translate StateTreeChange__get_key_def;
val StateTreeChange__get_account_thm = translate StateTreeChange__get_account_def;

(*val StateTreePrivate__account_id_bit_at_thm = m_translate StateTreePrivate__account_id_bit_at_def;*)
val StateTreePrivate__get_store_thm = translate StateTreePrivate__get_store_def;
val StateTreePrivate__get_node_thm = translate StateTreePrivate__get_node_def;

val StateTree__get_version_thm = translate StateTree__get_version_def;
(*
val StateTree__empty_thm = translate StateTree__empty_def;
val StateTree__init_thm = translate StateTree__init_def;
*)

val _ = export_theory ();
