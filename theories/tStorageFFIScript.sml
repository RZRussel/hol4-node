(*
  Logical model of filesystem and I/O streams
*)
(*
load "preamble";
load "cfHeapsBaseTheory";
load "MarshallingTheory";
*)
open preamble mlstringTheory cfHeapsBaseTheory MarshallingTheory;

val _ = new_theory"tStorageFFI";

val _ = option_monadsyntax.temp_add_option_monadsyntax();

val _ = Datatype `mode = ReadMode | WriteMode`;

val _ = Datatype `
 dbIO = <|  DB: bool;
            err: bool;
            data: (num # mode) list;
         |>
`;
val dbIO_component_equality = theorem"dbIO_component_equality";

(* conf == in, bytes == out, args == IO_datatype_to_show_db_and_else*)
val ffi_db_open_def = Define`
  ffi_db_open (conf: word8 list) bytes (db_state : dbIO) =
    do
      assert (db_state.DB = F);
      return (FFIreturn (LUPDATE 1w 0 bytes) db_state)   
    od ++
    do
      assert (db_state.err = T);
      return (FFIreturn (LUPDATE 0w 0 bytes) db_state)   
    od ++
    do
      assert (db_state.err = F);
      return (FFIreturn (LUPDATE 2w 0 bytes) db_state)   
    od`;


val ffi_db_close_def = Define`
  ffi_db_close (conf: word8 list) bytes (db_state : dbIO) =
    do
      assert (db_state.DB = T);
      return (FFIreturn (LUPDATE 1w 0 bytes) db_state)   
    od ++
    do
      return (FFIreturn (LUPDATE 0w 0 bytes) db_state)   
    od`;

val encode_DB_def = Define`
  encode_DB db =  encode_bool db`;

val encode_err_def = Define`
  encode_err err =  encode_bool err`;

val encode_data_def = Define`
  encode_data ev =  
encode_list (encode_pair (Num) (Num o mode2num) ) ev`;

val encode_def = Define `encode (ev:dbIO) =
  Cons
    (Cons (encode_DB ev.DB) (encode_err ev.err))
    (encode_data ev.data)
`;

Theorem encode_DB_11[simp]:
   !xs ys. (encode_DB xs = encode_DB ys) <=> (xs = ys)
Proof
  rw [] \\ eq_tac \\ rw [encode_DB_def]
  \\ fs [encode_bool_def,FORALL_PROD]
QED


Theorem encode_err_11[simp]:
   !xs ys. (encode_err xs = encode_err ys) <=> (xs = ys)
Proof
  rw [] \\ eq_tac \\ rw [encode_err_def]
  \\ fs [encode_bool_def,FORALL_PROD]
QED

Theorem encode_data_11[simp]:
   !xs ys. (encode_data xs = encode_data ys) <=> (xs = ys)
Proof
 rw [] \\ eq_tac \\ rw [encode_data_def]
  \\ drule encode_list_11
  \\ fs [encode_pair_def,FORALL_PROD] \\
  METIS_TAC [fetch "StorageFFI" "mode2num_11"]
  \\ fs [encode_pair_def,FORALL_PROD]
QED

Theorem encode_11[simp]:
   !x y. (encode x = encode y) <=> (x = y)
Proof
  fs [encode_def] \\ rw [] \\ eq_tac \\ rw []
  \\ fs [dbIO_component_equality]
QED

val decode_encode = new_specification("decode_encode",["decode"],
  prove(``?decode. !cls. decode (encode cls) = SOME cls``,
        qexists_tac `\f. some c. encode c = f` \\ fs [encode_11]));
val _ = export_rewrites ["decode_encode"];

val db_ffi_part_def = Define`
  db_ffi_part = (encode,decode,
    [("db_open",ffi_db_open);
     ("db_close",ffi_db_close)])`;

val _ = export_theory();

