open preamble

val _ = new_theory "tOrdering";

Definition Ordering__Equal_def:
  Ordering__Equal = EQUAL
End 

Definition Ordering__Greater_def:
  Ordering__Greater = GREATER
End

Definition Ordering__Less_def:
  Ordering__Less = LESS
End

val _ = export_theory ();

