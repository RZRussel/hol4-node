open tIntTheory
open tListTheory
open tWord8Theory
open tByteArrayTheory

open preamble
open basis
open ml_monad_translator_interfaceLib

open tMonadicTheory
val _ = new_theory "tHex";

(** START OF Hex **)
(* https://gitlab.com/InnoChain/node-ml/-/blob/master/primitive/utils/Hex.sml *)

Definition List__foldl_def:
  List__foldl f e l = mllist$foldl f e l
End

Definition String__str_def:
  String__str : char -> mlstring = mlstring$str
End

Definition String__isPrefix_def:
  String__isPrefix : mlstring -> mlstring -> bool = mlstring$isPrefix
End

Definition String__explode_def:
  String__explode : mlstring -> string = mlstring$explode
End

Definition String__substring_def:
  String__substring : mlstring -> num -> num -> mlstring = mlstring$substring 
End

Definition String__size_def:
  String__size : mlstring -> num = mlstring$strlen
End

Definition Word8__orb_def:
  Word8__orb (x:word8) (y:word8) : word8 = x || y
End

Definition Hex__nibble_to_char2_def:
  Hex__nibble_to_char2 (nibble: word8) =
    failwith (HexExn (UndefinedHexByte nibble))
End
(*val Hex__nibble_to_char2_thm = m_translate Hex__nibble_to_char2_def;*)


Definition Hex__nibble_to_char_def:
  Hex__nibble_to_char (nibble: word8) : (unit, char, state_exn) M =
    case (Word8__toInt nibble) of
        0 => return (#"0")
      | 1 => return (#"1")
      | 2 => return (#"2")
      | 3 => return (#"3")
      | 4 => return (#"4")
      | 5 => return (#"5")
      | 6 => return (#"6")
      | 7 => return (#"7")
      | 8 => return (#"8")
      | 9 => return (#"9")
      | 10 => return (#"a")
      | 11 => return (#"b")
      | 12 => return (#"c")
      | 13 => return (#"d")
      | 14 => return (#"e")
      | 15 => return (#"f")
      | _ => failwith (HexExn (UndefinedHexByte nibble))
End

Definition Hex__char_to_nibble_def:
  Hex__char_to_nibble ch =
    case ch of
      #"0" => return (Word8__fromInt 0)
      | #"1" => return (Word8__fromInt 1)
      | #"2" => return (Word8__fromInt 2)
      | #"3" => return (Word8__fromInt 3)
      | #"4" => return (Word8__fromInt 4)
      | #"5" => return (Word8__fromInt 5)
      | #"6" => return (Word8__fromInt 6)
      | #"7" => return (Word8__fromInt 7)
      | #"8" => return (Word8__fromInt 8)
      | #"9" => return (Word8__fromInt 9)
      | #"a" => return (Word8__fromInt 10)
      | #"b" => return (Word8__fromInt 11)
      | #"c" => return (Word8__fromInt 12)
      | #"d" => return (Word8__fromInt 13)
      | #"e" => return (Word8__fromInt 14)
      | #"f" => return (Word8__fromInt 15)
      | #"A" => return (Word8__fromInt 10)
      | #"B" => return (Word8__fromInt 11)
      | #"C" => return (Word8__fromInt 12)
      | #"D" => return (Word8__fromInt 13)
      | #"E" => return (Word8__fromInt 14)
      | #"F" => return (Word8__fromInt 15)
      | _ => failwith (HexExn (UndefinedHexChar ch))
End

Definition Hex__byte_to_hex_def:
  Hex__byte_to_hex (byte:word8) : (unit, mlstring, state_exn) M =
    do
      low_bits <<- Word8__andb byte (Word8__fromInt 15);
      high_bits <<- Word8__lshift byte 4;
      ch1 <- Hex__nibble_to_char high_bits;
      ch2 <- Hex__nibble_to_char low_bits;
      return ((String__str ch1) ^ (String__str ch2));
    od
End

Definition Hex__hex_and_bytes_concat_to_hex_def:
  Hex__hex_and_bytes_concat_to_hex (hex:mlstring) (bytes:word8 list) : (unit, mlstring, state_exn) M =
  do
    case bytes of
    [] => return hex
    | (byte::t) =>
      do
        h <- Hex__byte_to_hex byte;
        hex <<- (hex ^ h);
        Hex__hex_and_bytes_concat_to_hex hex t
      od 
  od
End

Definition Hex__bytes_to_hex_def:
  Hex__bytes_to_hex (bytes:word8 list) : (unit, mlstring, state_exn) M=
  do
    f <- Hex__hex_and_bytes_concat_to_hex (strlit "") (ByteArray__to_list bytes);
    return ((strlit "0x") ^ f);
  od
End

Definition Hex__chars_to_byte_def:
  Hex__chars_to_byte (x:char) (y:char) :  (unit, word8, state_exn) M =
    do
      wrd1 <- Hex__char_to_nibble x;
      wrd2 <- Hex__char_to_nibble y;
      return (Word8__orb (Word8__lshift wrd1 4) wrd2);
    od
End

Definition Hex__chars_to_byte_list_def:
  Hex__chars_to_byte_list (char_list:char list) (bytes_list:word8 list) :  (unit, word8 list, state_exn) M =
  do
    case char_list of
      [] => return (bytes_list)
      | (x::t1) =>
        case t1 of
          [] => failwith (StrExn "bad input")
          | (y::t2) =>
            do
              byte <- Hex__chars_to_byte x y;
              byte_list <- Hex__chars_to_byte_list t2 ((bytes_list) ++ [byte]);
              return(byte_list);
            od
  od
End

Definition Hex__hex_to_char_list_def:
  Hex__hex_to_char_list (hex:mlstring) : (unit, char list, state_exn) M =
    do
      if String__isPrefix (strlit "0x") hex then      
        return(String__explode (String__substring hex 2 ((String__size hex) - 2)))
    else
        return(String__explode hex)
    od
End

Definition Hex__hex_to_bytes_def:
  Hex__hex_to_bytes (hex:mlstring) : (unit, word8 list, state_exn) M =
  do
    char_list <- Hex__hex_to_char_list hex;
    if (Int__mod (List__length char_list) 2) = 0 then
      do
        byte_list <- Hex__chars_to_byte_list char_list [];
        return (ByteArray__from_list byte_list)
      od
    else
      failwith (HexExn (OddHex (String__explode hex)));
  od
End

(** END OF Hex **)

val _ = export_theory ();

