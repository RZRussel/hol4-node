open preamble
open ml_monad_translator_interfaceLib

open tBoolTheory
open tListTheory
open tStringTheory

open tSerializationTheory
open tSetProgTheory (*previous*)
val _ = new_theory "tSerializationProg";
val _ = m_translation_extends "tSetProg";

(* NEXT FUNCTION
    fun pow(i, n) = if n > 0 then
                        i * pow(i, n-1)
                    else
                        1
*)


val Serialization__pow_thm = translate Serialization__pow_def;
val Serialization__pow_v_def = (definition "serialization__pow_v_def");

(* NEXT FUNCTION
    fun decode_int_byte_array i n l =
        if (n < Word8Array.length i) andalso (l > 0) then
            (Word8.toInt (Word8Array.sub i n)) + (256 * (decode_int_byte_array i (n+1) (l-1)))
        else
            0
*)

val Serialization__decode_int_byte_array_thm = translate Serialization__decode_int_byte_array_def;
val Serialization__decode_int_byte_array_v_def = (definition "serialization__decode_int_byte_array_v_def");


(* NEXT FUNCTION
fun encode_int8 i =
let
 val str_size = 1
 val hash = Word8Array.array str_size ((Word8.fromInt (Int.mod i 256)));
in
 ( hash )
end;
*)

val Serialization__encode_int8_thm = translate Serialization__encode_int8_def;
val Serialization__encode_int8_v_def = (definition "serialization__encode_int8_v_def");

(* NEXT FUNCTION:
    fun decode_int8 i = (Word8.toInt (Word8Array.sub i 0),1)
*)

val Serialization__decode_int8_thm = translate Serialization__decode_int8_def;
val Serialization__decode_int8_v_def = (definition "serialization__decode_int8_v_def");


(* NEXT FUNCTION:
fun encode_int16 i =
        let
            val hash = ByteArray.from_list ((Word8.fromInt (Int.mod i 256)) ::
                                            (Word8.fromInt (Int.div i 256))::[]);
		in
			 (
              hash
             )
		end;
*)


val Serialization__encode_int16_thm = translate Serialization__encode_int16_def;
val Serialization__encode_int16_v_def = (definition "serialization__encode_int16_v_def");


(* NEXT FUNCTION:
fun encode_int16 i =
        let
            val hash = ByteArray.from_list ((Word8.fromInt (Int.mod i 256)) ::
                                            (Word8.fromInt (Int.div i 256))::[]);
		in
			 (
              hash
             )
		end;
*)

val Serialization__encode_int16_thm = translate Serialization__encode_int16_def;
val Serialization__encode_int16_v_def = (definition "serialization__encode_int16_v_def");


(* NEXT FUNCTION:
    fun decode_int16 i = (decode_int_byte_array i 0 2,2)
*)

val Serialization__decode_int16_thm = translate Serialization__decode_int16_def;
val Serialization__decode_int16_v_def = (definition "serialization__decode_int16_v_def");


(* NEXT FUNCTION:
fun encode_int32 i =
        let
            val hash = ByteArray.from_list ((Word8.fromInt (Int.mod i 256)) ::
                                            (Word8.fromInt (Int.mod (Int.div i 256) 256)) ::
                                            (Word8.fromInt (Int.mod (Int.div i (256*256)) 256) ) ::
                                            (Word8.fromInt (Int.div i (256*256*256)))::[]);
		in
			 (
              hash
             )
		end;
*)
val Serialization__encode_int32_thm = translate Serialization__encode_int32_def;
val Serialization__encode_int32_v_def = (definition "serialization__encode_int32_v_def");

(* NEXT FUNCTION:
    fun decode_int32 i = (decode_int_byte_array i 0 4,4)
*)

val Serialization__decode_int32_thm = translate Serialization__decode_int32_def;
val Serialization__decode_int32_v_def = (definition "serialization__decode_int32_v_def");


(* NEXT FUNCTION:
fun build_int_flex_list i =
        if i < 256 then
              (Word8.fromInt i)::[]
        else
              (Word8.fromInt (Int.mod i 256))::build_int_flex_list(Int.div i 256)
*)
val Serialization__build_int_flex_list_thm = translate Serialization__build_int_flex_list_def;
val Serialization__build_int_flex_list_v_def = (definition "serialization__build_int_flex_list_v_def");

(* ### several functions are ommited ### *)

(* NEXT FUNCTION:
    fun encode_int_flex i =
        let
            val hash = (
                       if i < 64 then
                            ByteArray.from_list (build_int_flex_list (i*4))
                       else if i < pow(2,14) then
                            ByteArray.from_list (build_int_flex_list (i*4 + 1))
                       else if i < pow(2,22) then
                            ByteArray.from_list ((build_int_flex_list (i*4 + 2))@((Word8.fromInt 0)::[]))
                       else if i < pow(2,30) then
                            ByteArray.from_list (build_int_flex_list (i*4 + 2))
                       else
                            let
                                val encoded_num = build_int_flex_list (i)
                                (*Prefix is needed to describe the number of bytes,
                                 utilised to store int*)
                                val utilitary_prefix =
                                    Word8.fromInt((((List.length encoded_num)-4)*4) + 3) :: []
                            in
                                ByteArray.from_list (utilitary_prefix @ encoded_num)
                            end
                       )
		in
              hash
		end;
*)
(*Definition asq_def:                                                                                     
  asq = []++[]                                                                 
End
val asq_thm = translate asq_def;*)

val Serialization__encode_int_flex_thm = translate Serialization__encode_int_flex_def;
val Serialization__encode_int_flex_v_def = (definition "serialization__encode_int_flex_v_def");

val Serialization__encode_bool_thm = translate Serialization__encode_bool_def;
val Serialization__decode_bool_thm = translate Serialization__decode_bool_def;
val Serialization__decode_int_flex_thm = translate Serialization__decode_int_flex_def;
val Serialization__string_to_word8_list_thm = translate Serialization__string_to_word8_list_def;
val Serialization__encode_string_thm = translate Serialization__encode_string_def;
val Serialization__decode_string_by_chars_thm = translate Serialization__decode_string_by_chars_def;


Definition pSerialization__decode_string_def:
  pSerialization__decode_string (s:word8 list) : (mlstring#int) =
    let
      (str_size, int_size) = Serialization__decode_int_flex s
    in
      String__implode (Serialization__decode_string_by_chars s int_size (str_size + int_size)), int_size+str_size
End
val pSerialization__decode_string_thm = translate pSerialization__decode_string_def;
(* why!!!??? 
val Serialization__decode_string_thm = translate Serialization__decode_string_def;
*)
val Serialization__encode_byte_array_thm = translate Serialization__encode_byte_array_def;
val Serialization__decode_byte_array_thm = translate Serialization__decode_byte_array_def;
val Serialization__encode_tuple2_thm = translate Serialization__encode_tuple2_def;
val Serialization__decode_decode_tuple2_thm = translate Serialization__decode_tuple2_def;

(* NEXT FUNCTION:
    fun encode_list_element l enc_fun =
        case l of
            el :: lst =>
            (
                    ( ByteArray.to_list(enc_fun(el))) @
                        (encode_list_element lst enc_fun)
            )
          | [] => []
*)
(* todo: change it!
a @ b |--> CONCAT_WITH a [b]
*)
val Serialization__encode_list_element_thm = translate Serialization__encode_list_element_def;
val Serialization__encode_list_element_v_def = (definition "serialization__encode_list_element_v_def");

(* NEXT FUNCTION:
    fun encode_list enc_fun l =
        ByteArray.from_list (
            ( ByteArray.to_list(encode_int_flex (List.length l) ) ) @
                 (encode_list_element l enc_fun)
        )
*)

val Serialization__encode_list_thm = translate Serialization__encode_list_def;
val Serialization__encode_list_v_def = (definition "serialization__encode_list_v_def");

val Serialization__read_list_thm = translate Serialization__read_list_def;
val Serialization__count_len_thm = translate Serialization__count_len_def;
val Serialization__build_lst_thm = translate Serialization__build_lst_def;
val Serialization__decode_list_thm = translate Serialization__decode_list_def;
val Serialization__encode_option_bool_thm = translate Serialization__encode_option_bool_def;
val Serialization__decode_option_bool_thm = translate Serialization__decode_option_bool_def;
val Serialization__encode_option_thm = translate Serialization__encode_option_def;
val Serialization__decode_option_thm = translate Serialization__decode_option_def;
val Serialization__encode_set_thm = translate Serialization__encode_set_def;

(* ???
val Serialization__decode_set_thm = translate Serialization__decode_set_def;
*)

val Serialization__encode_word8_thm = translate Serialization__encode_word8_def;
val Serialization__decode_word8_thm = translate Serialization__decode_word8_def;
val Serialization__encode_byte_array_as_list_thm = translate Serialization__encode_byte_array_as_list_def;
(* ???
val Serialization__decode_byte_array_as_list_thm = translate Serialization__decode_byte_array_as_list_def;
*)
val Serialization__decode_byte_array_as_list_thm = translate Serialization__decode_byte_array_as_list_def;
val Serialization__encode_bool_thm = translate Serialization__encode_bool_def;


val Serialization__encode_bool_thm = translate Serialization__encode_bool_def;
val Serialization__decode_bool_thm = translate Serialization__decode_bool_def;
val Serialization__decode_int_flex_thm = translate Serialization__decode_int_flex_def;
val Serialization__read_list_thm = translate Serialization__read_list_def;
val Serialization__count_len_thm = translate Serialization__count_len_def;
val Serialization__build_lst_thm = translate Serialization__build_lst_def;
val Serialization__decode_list_thm = translate Serialization__decode_list_def;


val _ = export_theory ();

