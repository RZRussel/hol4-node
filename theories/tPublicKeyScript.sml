open preamble
open tByteArrayTheory

val _ = new_theory "tPublicKey";

val _ = type_abbrev("PublicKey", ``:word8 list``);

Definition PublicKey__compare_def:
    PublicKey__compare = ByteArray__compare
End

val _ = export_theory ();
    

