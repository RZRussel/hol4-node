open preamble
open basis
open ml_monad_translator_interfaceLib

val _ = new_theory "tMonadic";
val _ = translation_extends "basisProg";

(* All used datatypes: *)
(* Data type for the exceptions *)
(*
exception UndefinedHexByte Word8.word;
exception UndefinedHexChar char;
exception OddHex string;
*)

Datatype:
  Hex__exn = | UndefinedHexByte word8
             | UndefinedHexChar char
             | OddHex string
End

Datatype:
  RawKey__exn = RawKeyIndexOutOfBounds int int
End

Datatype:
  storage_error =
    (* DB expected to be open but it is closed and vice versa *) 
    StorageWrongStateError
    (* Can't open or close db *)
    | StorageStateChangeError
    (* Can't save value by key to database *) 
    | StoragePutError
    (* Can't fetch value by key from database *) 
    | StorageGetError
    (* Can't remove a value by key from database *) 
    | StorageDeleteError
    (* Batch request must be closed to open new one and vice versa *) 
    | StorageBatchWrongStateError
    (* An error occured on attemp to apply batch request to database *) 
    | StorageBatchFinalizationError
    (* An error occured on attempt to fully clear database *) 
    | StorageDestroyError
    (* Unexpected error code received from ffi function *) 
    | StorageUndefinedError
End

Datatype:
  storage_result = DBSuccess | DBFailure storage_error
End

Datatype:
  Storage__exn = 
      StorageGetFailed string
    | StorageUnexpectedStatus storage_result
    | StorageWrongStateDetected bool
End

Datatype:
  raw_key = RawKey (bool vector)
End

Datatype:
  state_key = StateKey raw_key int
End

Datatype:
  StateTree__exn = StateTreeMissingNode state_key
End

Datatype:
  all__exn = StrExn string
    | RawKeyExn RawKey__exn
    | HexExn Hex__exn
    | StorageExn Storage__exn
    | StateTreeExn StateTree__exn
End

Datatype:
  state_exn = Fail1 all__exn
End

Type state_type = ``:unit``


val _ = register_type ``:state_type``;
val _ = register_type ``:all__exn``;


(* Translator configuration *)
val config = global_state_config |>
             with_exception ``:state_exn``;

(* Parser overloadings for exceptions *)
Overload failwith = ``raise_Fail1``
Overload handle_fail = ``handle_Fail1``

val assert_def = Define `
  assert b = if b then return () else failwith (StrExn "assert") `;

val _ = start_translation config;

val _ = export_theory ();

