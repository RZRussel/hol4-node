open preamble

open tWord8Theory
open tWord8ArrayTheory

open tHashFunctionFFITheory

val _ = new_theory "tHashFunction";


Definition Word8Array__substring_def:
  Word8Array__substring (arr:Word8Array) (start:int) (length:int) = arr (*temporary!*)
End

Definition HashFunction__size_def:
  HashFunction__size () = 32i
End

Definition HashFunction__zero_def:
  HashFunction__zero () = Word8Array__array (HashFunction__size ()) (Word8__fromInt 0)
End

Definition HashFunction__fill_def:
  HashFunction__fill value = Word8Array__array (HashFunction__size ()) (Word8__fromInt value)
End

Definition HashFunction__calculate_from_string_def:
  HashFunction__calculate_from_string message =
    let
      result = Word8Array__array (HashFunction__size () + 1) (Word8__fromInt 0)
    in
      (
(*
#(hash) message result;
*)
(*            if (Word8__toInt (Word8Array__sub result 0)) < 1 then raise HashCalculationError
            else (ByteArray__suffix result 1)
*)
()
      )
End

Definition HashFunction__calculate_from_bytes_def:
  HashFunction__calculate_from_bytes message =
    let
      length = Word8Array__length message
    in
      HashFunction__calculate_from_string (Word8Array__substring message 0 length)
End

val _ = export_theory ();
