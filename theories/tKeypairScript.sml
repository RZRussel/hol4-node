open preamble
open tByteArrayTheory 
val _ = new_theory "tKeypair";

Datatype:
    keypair = Keypair ByteArray ByteArray;
End

Definition Keypair__priv_size_def:
    Keypair__priv_size = 144 : int
End

Definition Keypair__pub_size_def:
    Keypair__pub_size = 144 : int
End

Definition Keypair_get_priv_key_def:
    Keypair__get_priv_key (Keypair priv _) = priv
End

Definition Keypair_get_pub_key_def:
    Keypair__get_pub_key (Keypair _ pub) = pub
End

val _ = export_theory ();

