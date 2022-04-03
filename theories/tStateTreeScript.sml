open tStateKeyTheory
open tMonadicTheory
open tRawKeyTheory
open tMapTheory
open tAccountTheory
open tStateNodeTheory

open preamble
open ml_monad_translator_interfaceLib

val _ = new_theory "tStateTree";

(*-------StateTreeReader-------*)

Definition StateTreeReader__read_def: (*stub*)
  StateTreeReader__read db key = NONE
End

(*-------StateTreeChange-------*)

Datatype:
  state_tree_change = StateTreeChange (state_key option) account
End

Definition StateTreeChange__compare_def:
  StateTreeChange__compare (StateTreeChange _ a1) (StateTreeChange _ a2) = 
    ByteArray__compare (Account__get_account_id a1) (Account__get_account_id a2)
End

Definition StateTreeChange__set_key_def:
  StateTreeChange__set_key (StateTreeChange _ a) k = StateTreeChange k a
End

Definition StateTreeChange__set_account_def:
  StateTreeChange__set_account (StateTreeChange k _) a = StateTreeChange k a
End

Definition StateTreeChange__get_key_def:
  StateTreeChange__get_key (StateTreeChange k _) = k
End

Definition StateTreeChange__get_account_def:
  StateTreeChange__get_account (StateTreeChange _ a) = a
End

(*-------StateTreePrivate-------*)

Datatype:
  state_tree = StateTree ((state_key, StateNode) map) int
End

Definition StateTreePrivate__account_id_bit_at_def:
  StateTreePrivate__account_id_bit_at account_id index : (state_type, bool, state_exn) M =
    RawKey__bit_at (RawKey__from_bytes account_id) index
End

Definition StateTreePrivate__get_store_def:
  StateTreePrivate__get_store (StateTree s _) = s
End

(*Definition StateTreePrivate__threshold_def:
  StateTreePrivate__threshold (change:state_tree_change) (index:int) = 
   do
     account <<- StateTreeChange__get_account change;
     res <- StateTreePrivate__account_id_bit_at (Account__get_account_id account) index;
     return (¬res);
   od
End

Definition StateTreePrivate__break_changes_def:
  StateTreePrivate__break_changes changes index =
    do
      all_changes <<- Set__to_list changes;
      th <- StateTreePrivate__threshold all_changes index;
      fun <<- (λ state_tree_chng. th);
      (lst0, lst1) <<- List__partition fun all_changes;
      set0 <<- Set__from_list StateTreeChange__compare lst0;
      set1 <<- Set__from_list StateTreeChange__compare lst1;
      return (set0, set1)
  od
End*)

Definition StateTreePrivate__get_node_def:
  StateTreePrivate__get_node store db key =
    let
      node = Map__lookup store key
    in
      if IS_SOME node then
        (THE node, store)
      else
        let
          db_node = StateTreeReader__read db key
        in
          getOpt (OPTION_MAP (λ n. (n, (Map__insert store key n))) db_node) (StateNull, store)
End

(*
Definition StateTreePrivate__preload_reachable_def:
  StateTreePrivate__preload_reachable store db key =
    do
      (node, store) <<- StateTreePrivate__get_node store db key;
      preload_children <- (λ store left right. =
        do
          preload_left <-
          store <<- getOpt (OPTION_MAP (λ k. StateTreePrivate__preload_reachable store db k) left) store;
          store <<- getOpt (OPTION_MAP (λ k. StateTreePrivate__preload_reachable store db k) right) store;
          return store;
        od
      );
      
      if (node = (StateLeaf _ _)) then
        return store;
      else if (node = (StateInternal _ left right)) then
        return (preload_children store left right);
      else if (node = StateNull) then
        failwith (StateTreeExn (StateTreeMissingNode key));

End
*)
(*----------StateTree-----------*)

Definition StateTree__get_version_def:
  StateTree__get_version (StateTree _ v) : int = v
End

Definition StateTree__empty_def:
  StateTree__empty = StateTree (Map__empty StateKey__compare) 0
End

Definition StateTree__init_def:
  StateTree__init version = StateTree (Map__empty StateKey__compare) version
End

Definition StateTree__reduce_def:
  StateTree__reduce tree new_version =
    if (new_version < 0) ∨ ((StateTree__get_version tree) <= new_version) then tree
    else
      let
        filter = (λ key node new_store. 
          if (StateKey__get_version key) <= new_version then
            Map__insert new_store key node
          else
            new_store
        );
        store = Map__foldr_with_key filter (Map__empty StateKey__compare) (StateTreePrivate__get_store tree)
       in
         (StateTree store new_version)
End

val _ = export_theory ();
