open tRawKeyTheory
open tSerializationTheory
open tRawKeyTheory
open tByteArrayTheory
open tIntTheory

open preamble

val _ = new_theory "tStateKey"

Datatype:
  state_key = StateKey raw_key int
End

Definition StateKey__create_def:
  StateKey__create r v = StateKey r v
End

Definition StateKey__get_raw_def:
  StateKey__get_raw (StateKey r _) = r
End

Definition StateKey__get_version_def:
  StateKey__get_version (StateKey _ v) = v
End

Definition StateKey__set_version_def:
  StateKey__set_version (StateKey r _) v = StateKey r v
End

Definition StateKey__key_length_def:
  StateKey__key_length (StateKey r _) = RawKey__length r
End

Definition StateKey__next_key_def:
  StateKey__next_key (StateKey r v) item = 
    StateKey (RawKey__concat r (RawKey__from_items [item])) v
End

Definition StateKey__inc_version_def:
  StateKey__inc_version (StateKey r v) = StateKey r (v + 1)
End

Definition StateKey__root_def:
  StateKey__root version = StateKey (RawKey__empty ()) version
End


Definition StateKey__compare_def:
  StateKey__compare (StateKey r1 v1) (StateKey r2 v2) = 
    let
      version_order = Int__compare v1 v2
    in
      if version_order = EQUAL then
        RawKey__compare r1 r2
      else
        version_order
End

Definition StateKey__equal_def:
  StateKey__equal k1 k2 = (StateKey__compare k1 k2 = EQUAL)
End

Definition StateKey__serialize_def:
  StateKey__serialize (StateKey raw version) =
    ByteArray__concat (RawKey__serialize raw) (Serialization__encode_int_flex version)
End

Definition StateKey__deserialize_def:
  StateKey__deserialize bytes =
    let
      (raw, (raw_len:int)) = RawKey__deserialize bytes;
      (version, (version_len:int)) = Serialization__decode_int_flex (DROP (Num raw_len) bytes);
    in
      (StateKey raw version, raw_len + version_len)
End

Definition StateKey__db_key_def:
  StateKey__db_key state_key =
    strlit("state_node") ^ (ByteArray__to_string (StateKey__serialize state_key))
End

val _ = export_theory ();
