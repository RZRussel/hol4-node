open preamble
open tByteArrayTheory
open tSetTheory
open tGuidTheory
open tAccountTheory
open tStateKeyTheory
open tWord8Theory
open tSerializationTheory
     
val _ = new_theory "tStateNode";

Datatype:
  StateNode = StateNull | StateInternal  (word8 list) (state_key option) (state_key option) | StateLeaf (word8 list) account;
End

        
Definition StateNode__left_child_def:
  StateNode__left_child s =
  case s of
    StateInternal _ l _ => l
  | _ => NONE
End

Definition StateNode__right_child_def:
  StateNode__right_child s =
  case s of
    StateInternal _ _ r => r
  | _ => NONE
End
    
        
Definition StateNode__equal_leaf_def:
  StateNode__equal_leaf (StateLeaf h1 a1) (StateLeaf h2 a2) =
  if ((ByteArray__compare h1 h2) = EQUAL) ∧ (Account__equal a1 a2) then T else F 
End

Definition StateNode__equal_internal_def:
  StateNode__equal_internal (StateInternal h1 l1 r1) (StateInternal h2 l2 r2) =
  if ((ByteArray__compare h1 h2) = EQUAL) ∧
     ( option_compare (StateKey__compare) l1 l2 ) = EQUAL ∧
     ( option_compare (StateKey__compare) r1 r2 ) = EQUAL
     then T else F
End
        
Definition StateNode__equal_def:
  StateNode__equal n1 n2 =
  case (n1, n2) of
    (StateNull, StateNull) => T
  | ( StateInternal h1 l1 r1, StateInternal h2 l2 r2 ) =>
      StateNode__equal_internal (StateInternal h1 l1 r1) (StateInternal h2 l2 r2)
  | (StateLeaf h1 a1, StateLeaf h2 a2) =>
      StateNode__equal_leaf (StateLeaf h1 a1) (StateLeaf h2 a2)
  | (_, _) => F             
End

Definition StateNode__encode_leaf_def:
  StateNode__encode_leaf hash a =
  ByteArray__concat hash (Account__serialize a)
End
       
Definition StateNode__encode_internal_def:
  StateNode__encode_internal hash left right =
  let
    left_encode = Serialization__encode_option (StateKey__serialize) left;
    right_encode = Serialization__encode_option (StateKey__serialize) right;
  in
    ByteArray__concat hash (ByteArray__concat left_encode right_encode)                                           
End

Definition StateNode__serialize_def:
  StateNode__serialize node = case node of
                                StateNull => Serialization__encode_int8 0
                              | StateInternal hash left right => ByteArray__concat (Serialization__encode_int8 1) (StateNode__encode_internal hash left right)
                              | StateLeaf hash account => ByteArray__concat (Serialization__encode_int8 2) (StateNode__encode_leaf hash account)
End

Definition StateNode__decode_StateKey_def:
  StateNode__decode_StateKey bytes =
  let
    (key , len : int) = (StateKey__deserialize bytes)
  in
    (key , len) 
End

        (*NOT READY*)
(*hash_len = HashFunction__size *)        
Definition StateNode__decode_internal_def:
  StateNode__decode_internal bytes type_len =
  let
    hash_len = 32i;
    hash = ByteArray__prefix bytes hash_len;
    (left , left_len) = Serialization__decode_option (StateNode__decode_StateKey) (ByteArray__suffix bytes hash_len);
    (right , right_len) = Serialization__decode_option (StateNode__decode_StateKey) (ByteArray__suffix bytes hash_len);        
  in
    StateInternal hash left right
End

   (*HOW TO CONVERT REAL TO INT?
    (right , right_len) = Serialization__decode_option (StateNode__decode_StateKey) (ByteArray__suffix bytes (hash_len + one_int_to_real(left_len)));*)

(*hash_len = HashFunction__size *)
Definition StateNode__decode_leaf_def:
  StateNode__decode_leaf bytes type_len =
  let
    hash_len = 32;
    hash = ByteArray__prefix bytes hash_len;
    (account, acc_len) = Account__deserialize (ByteArray__suffix bytes hash_len);
  in
    StateLeaf hash account, type_len + hash_len + acc_len
End
                       

val _ = export_theory ();
