open preamble
open tIntTheory
open tListTheory
open tWord8Theory
open tWord8ArrayTheory
open tByteArrayTheory
open tSetTheory
open tBoolTheory
open tStringTheory
val _ = new_theory "tSerialization";

(* NEXT FUNCTION
    fun pow(i, n) = if n > 0 then
                        i * pow(i, n-1)
                    else
                        1
*)

Theorem Serialization__pow_terminates:
  ∃(R :int # int -> int # int -> bool).
     WF R ∧
     ∀(q :int # int) (i :int) (n :int).
       (q = (i,n)) ∧ n > (0 :int) ⇒ R (i,n − (1 :int)) q
Proof
  WF_REL_TAC `(λ(x:int#int). λ(y:int#int). (0 ≤ SND x) /\ (SND x < SND y))`
  (* ... see example for q_def ... *)
  >| [
    cheat
  ,
    cheat
  ]
QED

Definition Serialization__pow_def:
 Serialization__pow q :int =
   case q of (i:int, n:int) =>
   if (n > 0) then
     i * Serialization__pow (i, n-1)
   else
     1
Termination
  simp [Serialization__pow_terminates]
End

(* NEXT FUNCTION
    fun decode_int_byte_array i n l =
        if (n < Word8Array.length i) andalso (l > 0) then
            (Word8.toInt (Word8Array.sub i n)) + (256 * (decode_int_byte_array i (n+1) (l-1)))
        else
            0
*)

Definition Serialization__decode_int_byte_array_def:
  Serialization__decode_int_byte_array (i:Word8Array) (n:int) (l:int):int =
    if (n < Word8Array__length i) /\(*translates as andalso*) (l > 0) then
      ((w2i (Word8Array__sub i n))) + (256 * (Serialization__decode_int_byte_array i (n+1) (l-1)))
    else
      0
Termination
  cheat
End


(* NEXT FUNCTION
fun encode_int8 i =
let
 val str_size = 1
 val hash = Word8Array.array str_size ((Word8.fromInt (Int.mod i 256)));
in
 ( hash )
end;
*)

Definition Serialization__encode_int8_def:
  Serialization__encode_int8 (i:int) =
    let
      str_size = (1:int);
      hash = Word8Array__array str_size (Word8__fromInt (i%256));
    in
      ( hash )
End

(* NEXT FUNCTION:
    fun decode_int8 i = (Word8.toInt (Word8Array.sub i 0),1)
*)
Definition Serialization__decode_int8_def:
  Serialization__decode_int8 (i:Word8Array) = (w2i (Word8Array__sub i 0),1:int)
End


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

(*
translation:
ByteArray.from_list |-->  ByteArray__from_list
Word8.fromInt |--> i2w
Int.div |--> /
*)

Definition Serialization__encode_int16_def:
  Serialization__encode_int16 i =
    let
      hash =  ByteArray__from_list ((i2w (i%256)) ::
        (i2w (i/256))::[]);
    in
      (hash)
End

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

Definition Serialization__encode_int16_def:
  Serialization__encode_int16 (i:int) =
    let
      hash = ByteArray__from_list
        (
           (Word8__fromInt (Int__mod i 256)) ::
          ((Word8__fromInt (Int__div i 256))::[])
        )
     in
       (hash)
End

(* NEXT FUNCTION:
    fun decode_int16 i = (decode_int_byte_array i 0 2,2)
*)
Definition Serialization__decode_int16_def:
  Serialization__decode_int16 i = (Serialization__decode_int_byte_array i 0 2, 2:int)
End

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
Definition Serialization__encode_int32_def:
  Serialization__encode_int32 i =
    let
      hash = ByteArray__from_list ((Word8__fromInt (Int__mod i 256)) ::
                                   (Word8__fromInt (Int__mod (Int__div i 256) 256)) ::
                                   (Word8__fromInt (Int__mod (Int__div i (256*256)) 256) ) ::
                                   (Word8__fromInt (Int__div i (256*256*256)))::[]);
    in
      (hash)
End

(* NEXT FUNCTION:
    fun decode_int32 i = (decode_int_byte_array i 0 4,4)
*)
Definition Serialization__decode_int32_def:
  Serialization__decode_int32 i = (Serialization__decode_int_byte_array i 0 4, 4:int)
End


(* NEXT FUNCTION:
fun build_int_flex_list i =
        if i < 256 then
              (Word8.fromInt i)::[]
        else
              (Word8.fromInt (Int.mod i 256))::build_int_flex_list(Int.div i 256)
*)
(* needs Int__div Int__mod Word8__fromInt *)
Definition Serialization__build_int_flex_list_def:
  Serialization__build_int_flex_list (i:int) : word8 list =
    if i < 256 then
      (Word8__fromInt i)::[]
    else
      (Word8__fromInt (Int__mod i 256))::(Serialization__build_int_flex_list(Int__div i 256))
Termination
  cheat
End

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

Definition Serialization__encode_int_flex_def:
  Serialization__encode_int_flex (i:int) :ByteArray =
    let
      hash = (
        if i < 64 then
          ByteArray__from_list (Serialization__build_int_flex_list (i*4))
        else
 if i < Serialization__pow(2,14) then
          ByteArray__from_list (Serialization__build_int_flex_list (i*4 + 1))
        else
if i < Serialization__pow(2,22) then
          ByteArray__from_list (
  (Serialization__build_int_flex_list (i*4 + 2)) ++ [Word8__fromInt 0]
)
        else
if i < Serialization__pow(2,30) then
          ByteArray__from_list (Serialization__build_int_flex_list (i*4 + 2))
        else
          let
            encoded_num = Serialization__build_int_flex_list (i);
            (*Prefix is needed to describe the number of bytes, utilised to store int*)
            utilitary_prefix =
              Word8__fromInt((((List__length encoded_num)-4)*4) + 3i) :: [];
          in
            ByteArray__from_list (utilitary_prefix ++ encoded_num)
         );
    in
      hash
End

Definition Serialization__decode_int_flex_def:
  Serialization__decode_int_flex (i:word8 list) : (int#int) =
    case Int__mod (Word8__toInt (Word8Array__sub i 0)) 4 of
      0 => Int__div (Serialization__decode_int_byte_array i 0 1) 4, 1
      | 1 => Int__div (Serialization__decode_int_byte_array i 0 2) 4, 2
      | 2 => Int__div (Serialization__decode_int_byte_array i 0 4) 4, 4
      | _ => 
        let
          len = ((Int__div (Word8__toInt (Word8Array__sub i 0)) 4) + 4)
        in
          ((Serialization__decode_int_byte_array i 1 len), len+1)
End

Definition Serialization__encode_bool_def:
  Serialization__encode_bool (b:bool) : Word8Array =
    let
      str_size = (1:int);
    in 
      if b then
        Word8Array__array str_size (Word8__fromInt 1)
      else
        Word8Array__array str_size (Word8__fromInt 0)
End

Definition Serialization__decode_bool_def:
  Serialization__decode_bool (b:word8 list) : (bool#int) = 
    if (Word8__toInt (Word8Array__sub b 0)) = 1 then
      (TRUE, 1)
    else
      (FALSE, 1)
End

(* NEXT FUNCTION:
    fun encode_list_element l enc_fun =
        case l of
            el :: lst =>
            (
                    ( ByteArray.to_list(enc_fun(el))) @
                        (encode_list_element lst enc_fun)
        Definition Serialization__encode_bool_def:
  Serialization__encode_bool b =
    let
      str_size = 1;
    in 
      if b = TRUE then
        Word8Array__array str_size (Word8__fromInt 1)
      else
        Word8Array__array str_size (Word8__fromInt 0)
End    )
          | [] => []
*)

Definition Serialization__string_to_word8_list_def:
  Serialization__string_to_word8_list (s:mlstring) (j:num) : (word8 list) =
    if j < (String__size s) then
      (Word8__fromInt &(ORD (String__sub s j))) :: 
        (Serialization__string_to_word8_list s (j+1))
    else
      []
Termination
  cheat
End

Definition Serialization__encode_string_def:
  Serialization__encode_string (s:mlstring) : (word8 list) =
    ByteArray__from_list (
      (
        ByteArray__to_list(
          Serialization__encode_int_flex &(String__size s)
        )
      ) ++ 
      (Serialization__string_to_word8_list s 0)
    )
End

Definition Serialization__decode_string_by_chars_def:
  Serialization__decode_string_by_chars (s:word8 list) (l:int) (r:int) : string =
    if (l < r) ∧ (l < (Word8Array__length(s))) then
      (CHR (Num (Word8__toInt (Word8Array__sub s l)))) ::
        (Serialization__decode_string_by_chars s (l+1) r)
    else
      []
Termination
  cheat
End

Definition Serialization__encode_byte_array_def:
  Serialization__encode_byte_array (byte_arr:word8 list) : (word8 list) = byte_arr
End

Definition Serialization__decode_string_def:
  Serialization__decode_string (s:word8 list) : (mlstring#int) = (String__implode "hello!", 0i)
End
(*
Definition Serialization__decode_string_def:
  Serialization__decode_string (s:word8 list) : (mlstring#int) = 
    (let
      (str_size, int_size) = Serialization__decode_int_flex s
    in
      (String__implode (Serialization__decode_string_by_chars s int_size (str_size + int_size)), int_size+str_size))
End
*)

Definition Serialization__decode_byte_array_def:
  Serialization__decode_byte_array (len:int) (byte_arr:word8 list) : (word8 list#int) = 
        (ByteArray__from_list( List__take (ByteArray__to_list(byte_arr)) len) , len)
End

Definition Serialization__encode_tuple2_def:
  Serialization__encode_tuple2 enc_fun1 enc_fun2 (e1, e2) : (word8 list)  =
    ByteArray__from_list(
       (ByteArray__to_list(enc_fun1 e1)) ++
       (ByteArray__to_list(enc_fun2 e2)) 
    )
End

Definition Serialization__decode_tuple2_def:
  Serialization__decode_tuple2 dec_fun1 dec_fun2 (tup:word8 list) =
    let
      (e1, len1) = dec_fun1 tup;
      enc_e2 = ByteArray__from_list(List__drop (ByteArray__to_list tup) (Num len1));
      (e2, len2) = dec_fun2 enc_e2
    in
      ((e1, e2), (len1 + len2))
End

Definition Serialization__encode_list_element_def:
  Serialization__encode_list_element l enc_fun =
        case l of
        | [] => []
        |    (e :: lst) =>
            (
              (ByteArray__to_list(enc_fun(e)))
                  ++
              (Serialization__encode_list_element lst enc_fun)

            )
Termination
  cheat
End

(* NEXT FUNCTION:
    fun encode_list enc_fun l =
        ByteArray.from_list (
            ( ByteArray.to_list(encode_int_flex (List.length l) ) ) @
                 (encode_list_element l enc_fun)
        )
*)

Definition Serialization__encode_list_def:
  Serialization__encode_list enc_fun l =
    ByteArray__from_list (
      (ByteArray__to_list(Serialization__encode_int_flex (List__length l) )) ++
      (Serialization__encode_list_element l enc_fun)
    )
End

Definition Serialization__read_list_def:
  Serialization__read_list l dec_fun (to_drop:int) (n:int) : ('a#int) list =
    if n > 0 then
      let
        new_l = ByteArray__from_list(List__drop (ByteArray__to_list l) (Num to_drop));
        (elem, len) = dec_fun (new_l)
      in
        (elem, len) :: (Serialization__read_list new_l dec_fun len (n-1))
    else
      []
Termination
  cheat
End

Definition Serialization__count_len_def:
  Serialization__count_len (lst:('a#int) list) : int = 
    case lst of 
      (_, len) :: t => len + (Serialization__count_len t)
      | [] => 0 
End

Definition Serialization__build_lst_def:
  Serialization__build_lst lst = 
    case lst of 
      (elem, _) :: t => elem :: Serialization__build_lst(t)
      | [] => []
End

Definition Serialization__decode_list_def:
  Serialization__decode_list (dec_fun:word8 list -> 'a#int) (l:word8 list) : ('a list#int) =
    let
      (list_len, int_len) = Serialization__decode_int_flex l;
      lst_temp = Serialization__read_list l (dec_fun:word8 list -> 'a#int)  int_len list_len;
      length = Serialization__count_len lst_temp;
      final_list = Serialization__build_lst lst_temp
    in
      ( final_list, (length + int_len) ) 
End

Definition Serialization__encode_option_bool_def:
  Serialization__encode_option_bool option_obj =
    case option_obj of
      NONE => (Word8Array__array 1 (Word8__fromInt 0))
      | SOME T => (Word8Array__array 1 (Word8__fromInt 1))
      | SOME F => (Word8Array__array 1 (Word8__fromInt 2))
End

Definition Serialization__decode_option_bool_def:
  Serialization__decode_option_bool obj_bytes = 
    case (Word8__toInt (Word8Array__sub obj_bytes 0)) of
      0 => (NONE, 1)
      | 1 => (SOME T, 1)
      | 2 => (SOME F, 1)
End

Definition Serialization__encode_option_def:
  Serialization__encode_option enc_fun option_obj =
    case option_obj of
      NONE => (Word8Array__array 1 (Word8__fromInt 0))
      | SOME obj => ByteArray__from_list(
        ((ByteArray__to_list(Word8Array__array 1 (Word8__fromInt 1)))) 
        ++ (ByteArray__to_list(enc_fun obj)))
End

Definition Serialization__decode_option_def:
  Serialization__decode_option dec_fun obj_bytes =
    case (Word8__toInt (Word8Array__sub obj_bytes 0)) of
      0 => (NONE, 1)
      | 1 =>
        let
          (obj, encode_len:int) = dec_fun (ByteArray__from_list(List__drop (ByteArray__to_list obj_bytes) 1))
        in
          (SOME obj, encode_len + 1)
End

Definition Serialization__encode_set_def:
  Serialization__encode_set enc_fun set_obj = 
    Serialization__encode_list (enc_fun) (Set__to_list set_obj)
End
(*?*)
Definition Serialization__decode_set_def:
  Serialization__decode_set dec_fun comparator set_bytes = 
    let 
      (list_obj, decode_size) = Serialization__decode_list (dec_fun) set_bytes
    in
      (Set__from_list (comparator) (list_obj), decode_size)
End

Definition Serialization__encode_word8_def:
  Serialization__encode_word8 (byte:word8) : (word8 list) =
    Serialization__encode_byte_array (ByteArray__from_list((byte) :: []))
End

Definition Serialization__decode_word8_def:
  Serialization__decode_word8 (byte:word8 list) : (word8#int) =
    let 
      (byte_arr, byte_arr_len) = Serialization__decode_byte_array (1:int) byte
    in
      (HD (ByteArray__to_list byte_arr), (1:int))
End

Definition Serialization__encode_byte_array_as_list_def:
  Serialization__encode_byte_array_as_list (byte_arr:word8 list) : (word8 list) =
    let
      word8_list = ByteArray__to_list byte_arr
    in
      (Serialization__encode_list (Serialization__encode_word8) word8_list)
End

(*?*)
Definition Serialization__decode_byte_array_as_list_def:
  Serialization__decode_byte_array_as_list (bytes:word8 list) : ((word8 list)#(int)) = ([],0i)
End
(*    let
      (word8_list, word8_list_len) = (Serialization__decode_list (Serialization__decode_word8) bytes);
    in
      (ByteArray__from_list word8_list, word8_list_len)
*)

Definition Serialization__decode_bool_def:
  Serialization__decode_bool (b:word8 list) : (bool#int) = 
    if (Word8__toInt (Word8Array__sub b 0)) = 1 then
      (TRUE, 1)
    else
      (FALSE, 1)
End

Definition Serialization__decode_int_flex_def:
  Serialization__decode_int_flex (i:word8 list) : (int#int) =
    case Int__mod (Word8__toInt (Word8Array__sub i 0)) 4 of
      0 => Int__div (Serialization__decode_int_byte_array i 0 1) 4, 1
      | 1 => Int__div (Serialization__decode_int_byte_array i 0 2) 4, 2
      | 2 => Int__div (Serialization__decode_int_byte_array i 0 4) 4, 4
      | _ => 
        let
          len = ((Int__div (Word8__toInt (Word8Array__sub i 0)) 4) + 4)
        in
          ((Serialization__decode_int_byte_array i 1 len), len+1)
End

Definition Serialization__read_list_def:
  Serialization__read_list l dec_fun (to_drop:int) (n:int) : ('a#int) list =
    if n > 0 then
      let
        new_l = ByteArray__from_list(List__drop (ByteArray__to_list l) (Num to_drop));
        (elem, len) = dec_fun (new_l)
      in
        (elem, len) :: (Serialization__read_list new_l dec_fun len (n-1))
    else
      []
Termination
  cheat
End

Definition Serialization__count_len_def:
  Serialization__count_len (lst:('a#int) list) : int = 
    case lst of 
      (_, len) :: t => len + (Serialization__count_len t)
      | [] => 0 
End

Definition Serialization__build_lst_def:
  Serialization__build_lst lst = 
    case lst of 
      (elem, _) :: t => elem :: Serialization__build_lst(t)
      | [] => []
End

Definition Serialization__decode_list_def:
  Serialization__decode_list (dec_fun:word8 list -> 'a#int) (l:word8 list) : ('a list#int) =
    let
      (list_len, int_len) = Serialization__decode_int_flex l;
      lst_temp = Serialization__read_list l (dec_fun:word8 list -> 'a#int)  int_len list_len;
      length = Serialization__count_len lst_temp;
      final_list = Serialization__build_lst lst_temp
    in
      ( final_list, (length + int_len) ) 
End

Definition Serialization__encode_bool_def:
  Serialization__encode_bool (b:bool) : Word8Array =
    let
      str_size = (1:int);
    in 
      if b then
        Word8Array__array str_size (Word8__fromInt 1)
      else
        Word8Array__array str_size (Word8__fromInt 0)
End


val _ = export_theory ();

