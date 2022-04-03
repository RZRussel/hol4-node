open mlstringTheory
open preamble

open tWord8Theory
open tWord8ArrayTheory
open tListTheory

val _ = new_theory "tByteArray";

val _ = type_abbrev("ByteArray", ``:word8 list``);

Definition ByteArray__make_empty_def:
  ByteArray__make_empty (length:int) : (word8 list) =
    Word8Array__array length (Word8__fromInt 0)
End

Definition ByteArray__range_def:
  ByteArray__range (bytes:word8 list) (start:num) (length:num) : (word8 list) = 
    TAKE length (DROP start bytes)
End

Definition ByteArray__concat_def:
  ByteArray__concat array1 array2 =
    array1 ++ array2
End

Definition ByteArray__from_list_def:
  ByteArray__from_list (w:word8 list) : ByteArray = w
End

Definition ByteArray__to_list_def:
  ByteArray__to_list (x:ByteArray) : word8 list = x
End

Definition ByteArray__suffix_def:
  ByteArray__suffix (x:word8 list) (n:int) : word8 list = 
  case n of
       | 0 => x
       | k =>
           case x of
           | [] => []
           | (h::tl) => ByteArray__suffix tl (k - 1)           
End

Definition ByteArray__prefix_def:
  ByteArray__prefix ((h::tl):word8 list) (n:int) : word8 list = 
  case n of
       0 => []
       | k => h::(ByteArray__prefix tl (k - 1))           
End

Definition ByteArray__sub_def:
  ByteArray__sub (x:ByteArray) (n:int) = list$EL (Num n) x
End

Definition ByteArray__length_def:
  ByteArray__length:ByteArray->int = λx. &(list$LENGTH x)
End

Definition ByteArray__compareFromIndex_def:
  ByteArray__compareFromIndex (index:int) (array1:ByteArray) (array2:ByteArray) length = 
    if index >= length then EQUAL
    else 
      let 
        value1 = Word8__toInt (ByteArray__sub array1 index);
        value2 = Word8__toInt (ByteArray__sub array2 index);
      in
        if value1 > value2 then GREATER
        else 
          if value1 < value2 then LESS
          else
            ByteArray__compareFromIndex (index + 1) array1 array2 length
Termination
  cheat
End


Definition ByteArray__compare_def:
  ByteArray__compare (array1:ByteArray) (array2:ByteArray) = 
    let 
      length1 = ByteArray__length array1;
      length2 = ByteArray__length array2;
    in 
      if length1 > length2 then GREATER
      else
        if length1 < length2 then LESS
        else
          ByteArray__compareFromIndex 0 array1 array2 length1
End

(*Definition ByteArray__concat_def:
  ByteArray__concat (a:ByteArray) (b:ByteArray) = (CONCAT_WITH a [b])
End*)

Definition ByteArray__concat_def:
  ByteArray__concat (array1:word8 list) (array2:word8 list) = APPEND array1 array2
End

Definition ByteArray__to_string_def:
  ByteArray__to_string bytes =
    strlit (List__map (λ byte. CHR (Num (Word8__toInt byte))) bytes)
End


val _ = export_theory ();

