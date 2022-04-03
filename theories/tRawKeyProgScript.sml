open tRawKeyTheory
open tTransactionWriterProgTheory (*previous*)

open preamble
open basis
open ml_monad_translator_interfaceLib
open mllistTheory


val _ = new_theory "tRawKeyProg";
val _ = m_translation_extends "tTransactionWriterProg";

val _ = register_type ``:raw_key``;

val RawKey__empty_thm = translate RawKey__empty_def;
val RawKey__empty_v_def = (definition "rawkey__empty_v_def");

val RawKey__from_items_thm = translate RawKey__from_items_def;
val RawKey__from_items_v_def = (definition "rawkey__from_items_v_def");

val RawKey__length_thm = translate RawKey__length_def;
val RawKey__length_v_def = (definition "rawkey__length_v_def");

val RawKey__compare_thm = translate RawKey__compare_def;
val RawKey__compare_v_def = (definition "rawkey__compare_v_def");

val RawKey__equal_thm = translate RawKey__equal_def;
val RawKey__equal_v_def = (definition "rawkey__equal_v_def");

val RawKey__bit_at_thm = m_translate RawKey__bit_at_def;
val RawKey__bit_at_def = (definition "rawkey__bit_at_v_def");

val RawKey__common_prefix_thm = translate RawKey__common_prefix_def;
val RawKey__common_prefix_v_def = (definition "rawkey__common_prefix_v_def");

val RawKey__concat_thm = translate RawKey__concat_def;
val RawKey__concat_v_def = (definition "rawkey__concat_v_def");

val RawKey__from_bytes_thm = translate RawKey__from_bytes_def;
val RawKey__from_bytes_v_def = (definition "rawkey__from_bytes_v_def");

val List__map_thm = translate List__map_def;

val RawKey__to_string_thm = translate RawKey__to_string_def;
val RawKey__to_string_v_def = (definition "rawkey__to_string_v_def");

val RawKey__next_thm = translate RawKey__next_def;
val RawKey__next_v_def = (definition "rawkey__next_v_def");

val RawKey__serialize_thm = translate RawKey__serialize_def;
val RawKey__deserialize_thm = translate RawKey__deserialize_def;

val _ = export_theory ();
