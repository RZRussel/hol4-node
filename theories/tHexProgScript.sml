open tHexTheory
open tGuidProgTheory (*previous*)

open preamble
open basis
open ml_monad_translator_interfaceLib

open tWord8ArrayTheory
open tWord8ProgTheory
open mllistTheory

val _ = new_theory "tHexProg";
val _ = m_translation_extends "tGuidProg";

val _ = translate mllistTheory.foldl_aux_def;
val _ = translate mllistTheory.foldl_def;
val List__foldl_thm = translate List__foldl_def;

val String__str_thm = translate String__str_def;
val String__isPrefix_thm = translate String__isPrefix_def;
val String__explode_thm = translate String__explode_def;
val String__substring_thm = translate String__substring_def;
val String__size_thm = translate String__size_def;
val Word8__orb_thm = translate Word8__orb_def;
(*
Overload failwith = ``raise_Fail1``
Overload handle_fail = ``handle_Fail1``
*)
(*
(* Translator configuration *)
val config = global_state_config |>
             with_exception ``:state_exn``;
(* Parser overloadings for exceptions *)
Overload failwith = ``raise_Fail1``
Overload handle_fail = ``handle_Fail1``
val assert_def = Define `
  assert b = if b then return () else failwith (StrExn "assert") `;
val _ = start_translation config;
*)
(*Overload failwith = ``raise_Fail1``*)
(*
val _ = start_translation tHexTheory.config; (*  (config) has not been declared in structure tHexTheory *)
*)
Definition Hex__nibble_to_char3_def:
  Hex__nibble_to_char3 (nibble: word8) : (unit, char, state_exn) M  =
    failwith (HexExn (UndefinedHexByte nibble))
End
Definition Hex__nibble_to_char3_def:
  Hex__nibble_to_char3 (nibble: word8) =
    raise_Fail1 (HexExn (UndefinedHexByte nibble))
End
(*val _ = m_translate raise_Fail1_def del*)
val Hex__nibble_to_char3_thm = m_translate Hex__nibble_to_char3_def;

val Hex__nibble_to_char_thm = m_translate Hex__nibble_to_char_def;
val Hex__char_to_nibble_thm = m_translate Hex__char_to_nibble_def;
val Hex__byte_to_hex_thm = m_translate Hex__byte_to_hex_def;
val Hex__hex_and_bytes_concat_to_hex_thm = m_translate Hex__hex_and_bytes_concat_to_hex_def;
val Hex__bytes_to_hex_thm = m_translate Hex__bytes_to_hex_def;
val Hex__chars_to_byte_thm = m_translate Hex__chars_to_byte_def;
val Hex__chars_to_byte_list_thm = m_translate Hex__chars_to_byte_list_def;
val Hex__hex_to_char_list_thm = m_translate Hex__hex_to_char_list_def;
val Hex__hex_to_bytes_thm = m_translate Hex__hex_to_bytes_def;

val _ = export_theory ();

