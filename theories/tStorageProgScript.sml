(* 
load "preamble";
load "basis";
load "ml_translatorLib";
load "ml_progLib";
load "ml_translatorTheory";
load "basisFunctionsLib";
load "Word8ArrayProgTheory";
load "holyHammer";
*)
open holyHammer;
open preamble basis basisProgTheory;
open ml_translatorLib ml_progLib ml_translatorTheory;
open integerTheory cfDivTheory cfDivLib;
open cfMonadTheory;

open tStorageTheory
open tReactorProgTheory (*previous*)
val _ = new_theory "tStorageProg";
val _ = translation_extends "tReactorProg";

val foo_def = Define`
  foo : char -> word8 = (\ch. n2w (ORD ch))`;

val foo_res = translate foo_def;

val cwl = (append_prog o process_topdecs) `
  fun convertW8Array2List a =
      List.map (foo) 
      (String.explode 
              (Word8Array.substring a 0 (Word8Array.length a))
      );`;


fun xcf' s = xcf_with_def (s) 
             (DB.fetch "StorageProg" ( s ^ "_v_def"));

val lstmapthm = ListProgTheory.map_1_v_thm |> INST_TYPE [alpha |-> ``:word8``, beta |-> ``:char``];

Theorem convertW8Array2List_spec:
     !a. app (p:'ffi ffi_proj) convertW8Array2List_v [av]
     (W8ARRAY av a)
     (POSTv v.  & LIST_TYPE WORD8 a v * W8ARRAY av a) 
Proof
xcf' "convertW8Array2List"
   \\ rpt (xlet_auto THEN1 xsimpl) 
   >> (xapp_spec (lstmapthm)
   \\ xsimpl)
   \\ map_every qexists_tac [`(MAP (CHR o (w2n :word8 -> num )) (a :word8 list))`,
                             `foo`,
                              `WORD8`, 
                              `CHAR`]
   \\ rw[] \\ rw[foo_res] 
   \\ fs[MAP_MAP_o, o_DEF, foo_def, wordsTheory.w2n_n2w, stringTheory.CHR_ORD, ORD_BOUND]
QED

fun xcf' s = xcf_with_def ("StoragePrivate." ^ s) 
             (DB.fetch "StorageProg" ("StoragePrivate_" ^ s ^ "_v_def"));


val _ = option_monadsyntax.temp_add_option_monadsyntax();
(* Avoid printing potentially very long output *)
(* val _ = Globals.max_print_depth := 10000000; *)

Datatype:
   storage = Storage bool
End

(* Internal type that represents ffi error returned as a numeric code *)
Datatype:
  storage_error = (* DB expected to be open but it is closed and vice versa *) 
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

(* Internal type to represent result of ffi function call *)
Datatype:
   storage_result = DBSuccess | DBFailure storage_error
End

val _ = (use_full_type_names := false);
val _ = register_type ``:storage``;
val _ = register_type ``:storage_error``;
val _ = register_type ``:storage_result``;
val _ = (use_full_type_names := true);

val STORAGE_TYPE_thm = fetch "StorageProg" "STORAGE_TYPE_def";
val STORAGE_RESULT_TYPE_thm = fetch "StorageProg" "STORAGE_RESULT_TYPE_def";

val _ = (append_prog o process_topdecs)
`
exception StorageFailed int;
`;

fun get_exn_conv name =
  EVAL ``lookup_cons (Short ^name) ^(get_env (get_ml_prog_state ()))``
  |> concl |> rand |> rand |> rand;

val StorageFailed = get_exn_conv ``"StorageFailed"``;

val StorageFailed_exn_def = Define `
  StorageFailed_exn r rv v =   
  (v = Conv (SOME ^StorageFailed) [rv] /\ INT r rv)`;

(* ************************************ *)
val _ = ml_prog_update (open_module "StoragePrivate");
(* ************************************ *)
val _ = (append_prog o process_topdecs)
   `fun set_has_batch has_batch = Storage has_batch;`;

Theorem set_has_batch_correct:
   !hb hbv st stv.
     BOOL hb hbv ==>  
     app (p:'ffi ffi_proj) StoragePrivate_set_has_batch_v [hbv]
     emp
     (POSTv v. & STORAGE_TYPE (Storage hb) v)
Proof
  xcf' "set_has_batch" \\
  xcon \\ xsimpl \\ rw[STORAGE_TYPE_thm]
QED

val _ = (append_prog o process_topdecs)
   `fun prepare_bool_param param = 
        if param then
            "1"
        else
            "0";`;

Theorem prepare_bool_param_correct:
   ! param paramv. BOOL param paramv ==>
    app (p:'ffi ffi_proj) StoragePrivate_prepare_bool_param_v [paramv]
     emp
     (POSTv v. & STRING_TYPE (if param then (implode "1") else (implode "0")) v )
Proof
  xcf' "prepare_bool_param"  \\
  xif \\ xlit \\ xsimpl \\ fs[implode_def]
QED

Definition parse_status_def:
  parse_status (result: word8 list) =
  let
  (status : int) = (if (result <> [])  
                          then w2i (HD result)
                          else 10);
        in
            case status of
                 0 => DBSuccess
                | 1 => DBFailure StorageWrongStateError
                | 2 => DBFailure StorageStateChangeError
                | 3 => DBFailure StoragePutError
                | 4 => DBFailure StorageGetError
                | 5 => DBFailure StorageDeleteError
                | 6 => DBFailure StorageGetError
                | 7 => DBFailure StorageBatchWrongStateError
                | 8 => DBFailure StorageBatchFinalizationError
                | 9 => DBFailure StorageDestroyError
                | _ => DBFailure StorageUndefinedError
End

val parse_status_res = translate parse_status_def;
(* ************************************ *)
val _ = ml_prog_update (close_module NONE);
(* ************************************ *)

val _ = ml_prog_update (open_module "Storage");

fun xcf' s = xcf_with_def ("Storage." ^ s) 
             (DB.fetch "StorageProg" ("Storage_" ^ s ^ "_v_def"));

Definition get_has_batch_def:
    get_has_batch (Storage has_batch)  = has_batch
End

val get_has_batch_res = translate get_has_batch_def;

val _ = (append_prog o process_topdecs)
   `fun create () = Storage False;
    `;

Theorem create_correct:
   app (p:'ffi ffi_proj) Storage_create_v [Conv NONE []]
     emp
     (POSTv v. & STORAGE_TYPE (Storage F) v)
Proof
  xcf' "create" \\
  xmatch \\ xlet_auto \\ xsimpl >> (xcon \\ xsimpl) 
  \\ fs[STORAGE_TYPE_thm, BOOL_def] \\ EVAL_TAC
QED

val _ = (append_prog o process_topdecs)
`
fun db_open storage = 
    	let
    		val result = Word8Array.array 1 (Word8.fromInt 10)
        val a = #(db_open) "" result 
    	in
    		if ((StoragePrivate.parse_status (convertW8Array2List result)) = Dbsuccess) 
        then storage
        else raise (StorageFailed (Word8.toInt (Word8Array.sub 0 result)))
    	end;
`;

val _ = (append_prog o process_topdecs)
`
    fun db_close storage = 
    	let
    		val result = Word8Array.array 1 (Word8.fromInt 10)
        val a = #(db_close) "" result
    	in
        if ((StoragePrivate.parse_status (convertW8Array2List result)) = Dbsuccess)
        then storage
        else raise (StorageFailed (Word8.toInt (Word8Array.sub 0 result)))
    	end;
`;


val _ = ml_prog_update (close_module NONE);

val StoragePrivate__parse_status_thm = translate StoragePrivate__parse_status_def;
val p__handle_status_thm = m_translate p__handle_status_def;

val _ = export_theory();

