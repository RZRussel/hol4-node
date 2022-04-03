open preamble
open ml_monad_translator_interfaceLib

open tByteArrayTheory
open tResultProgTheory (*previous*)
val _ = new_theory "tByteArrayProg";
val _ = m_translation_extends "tResultProg";

val _ = translate listTheory.TAKE_def;
val _ = translate listTheory.DROP_def;

val ByteArray__range_thm = translate ByteArray__range_def;
val ByteArray__concat_thm = translate ByteArray__concat_def;
val ByteArray__make_empty_thm = translate ByteArray__make_empty_def;
val ByteArray__from_list_thm = translate ByteArray__from_list_def;
val ByteArray__to_list_thm = translate ByteArray__to_list_def;
val ByteArray__suffix_thm = translate ByteArray__suffix_def;
val ByteArray__sub_thm = translate ByteArray__sub_def;
val ByteArray__length_thm = translate ByteArray__length_def;
val ByteArray__compareFromIndex_thm = translate ByteArray__compareFromIndex_def;
val ByteArray__compare_thm = translate ByteArray__compare_def;
(*val ByteArray__equal_thm = translate ByteArray__equal_def;*)


val ByteArray__concat_thm = translate ByteArray__concat_def
(* problem with strlit
val ByteArray__to_string_thm = translate ByteArray__to_string_def;
*)


val _ = export_theory ();
