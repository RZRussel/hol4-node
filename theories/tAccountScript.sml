open preamble
open tByteArrayTheory
open tSetTheory
open tListTheory
open tGuidTheory
open tSerializationTheory
open tKeypairTheory
open tPublicKeyTheory     
        

val _ = new_theory "tAccount";
    

Datatype:
    account = Account Guid (ByteArray set) int int bool (ByteArray option) ((mlstring # ByteArray) list);
End

Definition Account__contract_def:
    Account__contract : int = 0
End

Definition Account__user_def:
    Account__user : int = 1
End

Definition Account__master_def:
    Account__master : int = 2
End
  
Definition Account__state_key_def:
  Account__state_key : char list = "state"
End
        
Definition Account__init_def:
  Account__init : account = Account Guid__zero (Set__empty ByteArray__compare) 0 0 F NONE []
End

Definition Account__create_def:
  Account__create account_id public_keys account_type nonce is_confirmed code storage : account=
  (Account account_id public_keys account_type nonce is_confirmed code storage)
End

Definition Account__create_user_def:
  Account__create_user account_id public_keys =
  Account__create account_id public_keys (Account__user) 0 T NONE []
End
        
Definition Account__create_contract_def:
  Account__create_contract account_id public_keys =
  Account__create account_id public_keys (Account__contract) 0 T NONE []
End
             
Definition Account__create_master_def:
  Account__create_master account_id public_keys =
  Account__create account_id public_keys (Account__master) 0 T NONE []
End

Definition Account__get_account_id_def:
  Account__get_account_id (Account account_id _ _ _ _ _ _) = account_id
End
Definition Account__get_public_keys_def:
  Account__get_public_keys (Account _ public_keys _ _ _ _ _) = public_keys
End
Definition Account__get_account_type_def:
  Account__get_account_type (Account _ _ account_type _ _ _ _) = account_type
End
Definition Account__get_nonce_def:
  Account__get_nonce (Account _ _ _ nonce _ _ _) = nonce
End
Definition Account__get_code_def:
  Account__get_is_confirmed (Account _ _ _ _ is_confirmed _ _) = is_confirmed
End
Definition Account__get_code_def:
  Account__get_code (Account _ _ _ _ _ code _) = code
End
Definition Account__get_storage_def:
  Account__get_storage (Account _ _ _ _ _ _ storage ) = storage
End
        
Definition Account__is_contract_def:
  Account__is_contract (Account _ _ account_type _ _ _ _) = if (account_type = 0) then T else F
End

Definition Account__set_account_id_def:
  Account__set_account_id (Account _ public_keys account_type nonce is_confirmed code storage) account_id = 
  Account account_id public_keys account_type nonce is_confirmed code storage
End

Definition Account__set_public_keys_def:
  Account__set_public_keys (Account account_id _ account_type nonce is_confirmed code storage) public_keys = 
  Account account_id public_keys account_type nonce is_confirmed code storage
End

Definition Account__set_account_type_def:
  Account__set_account_type (Account account_id public_keys _ nonce is_confirmed code storage) account_type = 
  Account account_id public_keys account_type nonce is_confirmed code storage
End

Definition Account__set_nonce_def:
  Account__set_nonce (Account account_id public_keys account_type _  is_confirmed code storage) nonce = 
  Account account_id public_keys account_type nonce is_confirmed code storage
End

Definition Account__set_is_confirmed_def:
  Account__set_is_confirmed (Account account_id public_keys account_type nonce _ code storage) is_confirmed = 
  Account account_id public_keys account_type nonce is_confirmed code storage
End

Definition Account__set_code_def:
  Account__set_code (Account account_id public_keys account_type nonce is_confirmed _ storage) code = 
  Account account_id public_keys account_type nonce is_confirmed code storage
End

Definition Account__set_storage_def:
  Account__set_storage (Account account_id public_keys account_type nonce is_confirmed code _) storage = 
  Account account_id public_keys account_type nonce is_confirmed code storage
End

Definition Account__serialize_def:
  Account__serialize (Account account_id public_keys account_type nonce is_confirmed code storage) =
  ByteArray__from_list(
    CONCAT_WITH (ByteArray__to_list account_id)
    [
      (ByteArray__to_list (Serialization__encode_set (Serialization__encode_byte_array) public_keys));                          
      (ByteArray__to_list (Serialization__encode_int8 account_type));
      (ByteArray__to_list (Serialization__encode_int32 nonce));
      (ByteArray__to_list (Serialization__encode_bool is_confirmed));
      (ByteArray__to_list (Serialization__encode_option (Serialization__encode_byte_array_as_list) code));                  
      (ByteArray__to_list (Serialization__encode_list (Serialization__encode_tuple2 (Serialization__encode_string) (Serialization__encode_byte_array_as_list)) storage))        
    ]   
        )
End

Definition Account__compare_def:
  Account__compare a1 a2 = T
End
        
Definition Account__equal_def:
  Account__equal a1 a2 = if Account__compare a1 a2 then T else F
End    
        
Definition Account__deserialize_def:
  Account__deserialize account_bytes : (account # int)=
  let
    (account_id, account_id_len) = Serialization__decode_byte_array (Guid__size) account_bytes;
    updated_bytes = ByteArray__from_list (List__drop (ByteArray__to_list account_bytes) (Num account_id_len));
    (public_keys, public_keys_len) = Serialization__decode_set (Serialization__decode_byte_array (Keypair__pub_size)) (PublicKey__compare) updated_bytes;
    updated_bytes = ByteArray__from_list (List__drop (ByteArray__to_list updated_bytes) (Num public_keys_len));
    (account_type, account_type_len) = Serialization__decode_int8 updated_bytes;
    updated_bytes = ByteArray__from_list (List__drop (ByteArray__to_list updated_bytes) (Num account_type_len));
    (nonce, nonce_len) = Serialization__decode_int32 updated_bytes;
    updated_bytes = ByteArray__from_list (List__drop (ByteArray__to_list updated_bytes) (Num nonce_len));
    (is_confirmed, is_confirmed_len) = Serialization__decode_bool updated_bytes;
    updated_bytes = ByteArray__from_list (List__drop (ByteArray__to_list updated_bytes) (Num is_confirmed_len));
    (code, code_len) = Serialization__decode_option (Serialization__decode_byte_array_as_list) updated_bytes;
    updated_bytes = ByteArray__from_list (List__drop (ByteArray__to_list updated_bytes) (Num code_len));
    (storage, storage_len) = Serialization__decode_list (Serialization__decode_tuple2 (Serialization__decode_string) (Serialization__decode_byte_array_as_list)) updated_bytes;
              
  in
    (Account account_id public_keys account_type nonce is_confirmed code storage,
     account_id_len + public_keys_len + account_type_len + nonce_len + is_confirmed_len + code_len + storage_len) 
End

    
val _ = export_theory ();

