(*path to origin file node-ml/primritive/utils/Set.sml*)
open preamble
open tBoolTheory
open tListTheory
open tOrderingTheory

val _ = new_theory "tSet";

Datatype:
  set = Set ('a -> 'a -> ordering) ('a list)
End

Definition Set__member_def:
  Set__member (Set comparator s) obj =
    case s of
      [] => False
      | item::items =>
        if (comparator obj item) = Equal
        then True
        else
          Set__member (Set comparator items) obj
End

Definition Set__add_def:
  Set__add item (Set comparator set) =
    if ¬(Set__member (Set comparator set) item) then (Set comparator (item::set))
    else (Set comparator set)
End

Definition Set__empty_def:
  Set__empty comparator = Set comparator []
End

Definition Set__from_list_def:
  Set__from_list comparator lst =
    List__foldl (λ item set. Set__add item set) (Set__empty comparator) lst
End

Definition Set__to_list_def:
  Set__to_list (Set comparator lst) =
    let
      greater_than x y comparator =
        case comparator x y of
          Greater           => True
        | _                 => False
      in
        QSORT (λ x y. greater_than x y comparator) lst
End


val _ = export_theory ();
