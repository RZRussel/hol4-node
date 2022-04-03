open preamble
val _ = new_theory "tList";
open ml_monad_translator_interfaceLib

Definition List__length_def:
  List__length : 'a list -> int = λx. & (LENGTH x)
End

Definition List__take_def:
  List__take l (x:int) = mllist$take l ((Num x):num)
End

Definition List__unzip_def:
  List__unzip = list$UNZIP
End

Definition List__zip_def:
  List__zip = list$ZIP
End

Definition List__takeUntil_def:
  List__takeUntil = mllist$takeUntil
End

Definition List__map_def:
  List__map = MAP
End

val partition_aux_def = Define`
  (partition_aux f [] pos neg =
    (REVERSE pos, REVERSE neg)) /\
    (partition_aux f (h::t) pos neg = if f h then partition_aux f t (h::pos) neg
      else partition_aux f t pos (h::neg))`;

val partition_def = Define`
  partition (f : 'a -> bool) l = partition_aux f l [] []`;

Definition List__partition_aux_def:
  (List__partition_aux f [] pos neg =
    (REVERSE pos, REVERSE neg)) ∧ 
  (List__partition_aux f (h::t) pos neg =
    if f h then
      List__partition_aux f t (h::pos) neg
    else
      List__partition_aux f t pos (h::neg))
End

Definition List__partition_def:
  List__partition (f:'a -> bool) l = 
    List__partition_aux f l [] []
End

Definition List__drop_def:
  List__drop l i = mllist$drop l i
End

Definition List__foldl_def:
  List__foldl f e l = mllist$foldl f e l
End

val _ = export_theory ();

