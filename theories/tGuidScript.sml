(*path to origin file node-ml/primritive/utils/Guid.sml*)

open preamble
open tWord8Theory
open tWord8ArrayTheory
open tByteArrayTheory

val _ = new_theory "tGuid";

val _ = type_abbrev("Guid", ``:word8 list``);

Definition Guid__size_def:
    Guid__size:int = 16
End

Definition Guid__zero_def:
    Guid__zero = Word8Array__array Guid__size (Word8__fromInt 0)
End

Definition Guid__generate_def:
    Guid__generate = Guid__zero
End


val _ = export_theory ();
