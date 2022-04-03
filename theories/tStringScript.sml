open preamble
open mlstringTheory

val _ = new_theory "tString";

Definition String__size_def:
  String__size : mlstring -> num = mlstring$strlen
End

Definition String__sub_def:
  String__sub (s:mlstring) (n:num) : char = mlstring$strsub s n
End

Definition String__implode_def:
  String__implode = mlstring$implode
End

Definition String__concat_def:
  String__concat = mlstring$concat
End
(*NB! not the String_concat
"sometext" |--> (strlit "sometext") or (implode "sometext") (it's the same)
*)


val _ = export_theory ();

