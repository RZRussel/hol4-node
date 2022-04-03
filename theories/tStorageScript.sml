open preamble
open tWord8Theory
open tByteArrayTheory
open tIntTheory
open tBigEndianTheory

open basis
open ml_monad_translator_interfaceLib
open tMonadicTheory

val _ = new_theory "tStorage";

Definition StoragePrivate__parse_status_def:
  StoragePrivate__parse_status result =
    let
      status = Word8__toInt (Word8Array__sub result 0)
    in
      case (status:int) of
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
End


Definition p__handle_status_def:
  p__handle_status (status:storage_result) key: (unit, int, state_exn) M =
   case status of
          DBSuccess => return (0:int)
        | DBFailure StorageWrongStateError => failwith (StorageExn (StorageWrongStateDetected TRUE))
        | DBFailure StorageGetError => failwith (StorageExn (StorageGetFailed key))
        | _ => failwith (StorageExn (StorageUnexpectedStatus status))
End

Definition p__prepare_def:
  p__prepare key : (unit, int, state_exn) M = 
    do
      prep_result <<- ByteArray__make_empty (1 + 8);
      (*(#(db_get_prepare) key prep_result;*)
      status <- p__handle_status (StoragePrivate__parse_status prep_result) key;
      return(BigEndian__byte8int8 (ByteArray__range prep_result 1 8))
    od
End

Definition p__finalize_def:
  p__finalize (vallen:int) key : (unit, word8 list, state_exn) M =
    let
      final_result = ByteArray__make_empty (vallen + 1)
    in
      if (Int__compare vallen 0) = GREATER then
        do
          status <- p__handle_status (StoragePrivate__parse_status final_result) key;
          return (ByteArray__range final_result 1 (Num vallen))
        od
      else
        return (ByteArray__range final_result 1 (Num vallen))
End

(*Definition p__finalize_def:
  p__finalize (vallen:int) key : (unit, word8 list, state_exn) M =
    do
      final_result <<- ByteArray__make_empty (vallen + 1);
      case (Int__compare vallen 0) of
        GREATER => 
          do
            status <- p__handle_status (StoragePrivate__parse_status final_result) key;
            return (ByteArray__range final_result 1 (Num vallen))
          od
        | _ => return (ByteArray__range final_result 1 (Num vallen))
    od
End*)

Definition Storage__get_def:
  Storage__get storage key : (unit, word8 list, state_exn) M = 
    do
      prep_result <<- ByteArray__make_empty (1 + 8);
      prepared <- p__prepare key;
      finalized <- p__finalize prepared key;
      return finalized
    od
End

val _ = export_theory ();


