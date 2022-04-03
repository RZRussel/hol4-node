open tStateKeyTheory
open tRawKeyProgTheory (*previous*)

open preamble
open basis
open ml_monad_translator_interfaceLib
open mlintTheory
open mlstringTheory

val _ = new_theory "tStateKeyProg";
val _ = m_translation_extends "tRawKeyProg";

(*val _ = register_type ``:state_key``;*)


val StateKey__create_thm = translate StateKey__create_def;
val StateKey__get_raw_thm = translate StateKey__get_raw_def;
val StateKey__get_version_thm = translate StateKey__get_version_def;
val StateKey__set_version_thm = translate StateKey__set_version_def;
val StateKey__key_length_thm = translate StateKey__key_length_def;
val StateKey__next_key_thm = translate StateKey__next_key_def;
val StateKey__inc_version_thm = translate StateKey__inc_version_def;
val StateKey__root_thm = translate StateKey__root_def;
(*
val StateKey__compare_thm = translate StateKey__compare_def;
val StateKey__equal_thm = translate StateKey__equal_def;
*)
val StateKey__serialize_thm = translate StateKey__serialize_def;
(* problem with  drop *)
val StateKey__deserialize_thm = translate StateKey__deserialize_def;

(* it depends on  ByteArray__to_string_thm
val StateKey__db_key_thm = translate StateKey__db_key_def;
*)
val _ = export_theory ();
