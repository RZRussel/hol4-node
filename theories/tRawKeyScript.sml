open tStringTheory
open tHexTheory
open tWord8ArrayTheory
open tVectorTheory
(*open tMiscTheory*)
open tMonadicTheory
open tVectorTheory
open tIntTheory
open tListTheory
open tWord8Theory
open tSerializationTheory

(*
open std_preludeTheory
*)
open preamble


val _ = new_theory "tRawKey";

Datatype:
  raw_key = RawKey (bool vector)
End

(* NEXT FUNCTION:
fun empty () = RawKey (Vector.fromList []);
*)
Definition RawKey__empty_def:
  RawKey__empty () = RawKey (Vector__fromList [])
End

(* NEXT FUNCTION:
fun from_items items = RawKey (Vector.fromList items);
*)
Definition RawKey__from_items_def:
  RawKey__from_items items = RawKey (Vector__fromList items)
End

(* NEXT FUNCTION:
fun length (RawKey v) = Vector.length v;
*)

Definition RawKey__length_def:
  RawKey__length (RawKey v) = Vector__length v
End

(* NEXT FUNCTION:
fun compare (RawKey v1) (RawKey v2) =
		Vector.collate Bool.compare v1 v2;
*)

Definition RawKey__compare_def:
  RawKey__compare (RawKey v1) (RawKey v2) =
		Vector__collate Bool__compare v1 v2
End

(* NEXT FUNCTION:
fun equal k1 k2 = (compare k1 k2 = Equal);
*)
Definition RawKey__equal_def:
  RawKey__equal k1 k2 = (RawKey__compare k1 k2 = Equal)
End

(* NEXT FUNCTION:
fun bit_at (RawKey v) index =
	let
		val len = Vector.length v
	in
		if len > index then
			Vector.sub v index
		else
			raise RawKeyIndexOutOfBounds len index
	end;
*)

Definition RawKey__bit_at_def:
  RawKey__bit_at x1 (index:int) : (state_type, bool, state_exn) M =
    case x1 of (RawKey v) =>
    do
      len <<- Vector__length v;
      if len > index then
        do
          st_ex_return (Vector__sub v index);
        od
      else
        do
          failwith (RawKeyExn (RawKeyIndexOutOfBounds len index));
        od
    od
End


Definition RawKey__common_prefix_def:
  RawKey__common_prefix a b =
  case (a, b) of ((RawKey v1), (RawKey v2)) =>
  let
    min_len = Int__min (Vector__length v1) (Vector__length v2);
    l1 = List__take (Vector__toList v1) min_len;
    l2 = List__take (Vector__toList v2) min_len;
    q0 = (List__zip (l1, l2));
    q1 = (λ p:bool # bool. ¬ ((FST p) = (SND p)));
    q  = (List__takeUntil q1 q0);
  in
    RawKey (Vector__fromList (FST (List__unzip q)))
End

(* NEXT FUNCTION:
       fun concat (RawKey prefix) (RawKey suffix) =
               RawKey (Vector.concat [prefix, suffix]);
*)
(*
,|-->;
*)
Definition RawKey__concat_def:
  RawKey__concat (RawKey prefix) (RawKey suffix) =
    RawKey (Vector__concat [prefix; suffix])
End

(* NEXT FUNCTION:
       fun from_bytes bytes =
               let
                       val bytes_len = Word8Array.length bytes

                       fun calc_at index =
                               let
                                       val byte_index = Int.div index 8
                                       val byte = Word8Array.sub bytes byte_index
                                       val is_zero_bit = (Word8.toInt (Word8.andb byte (Word8.<< (Word8.fromInt 1) (index - byte_index * 8))) = 0)
                               in
                                       not is_zero_bit
                               end
               in
                       RawKey (Vector.tabulate (bytes_len * 8) calc_at)
               end;
*)

Definition RawKey__from_bytes_def:
  RawKey__from_bytes (bytes:Word8Array) (*: raw_key*) =
    let
      bytes_len = Word8Array__length bytes;
      calc_at  = (λ (index:int).
        let
          byte_index = Int__div index 8i;
          byte = Word8Array__sub bytes byte_index;
          u1 = Word8__lshift (Word8__fromInt 1i) (index - byte_index * 8i);
          u2 = (Word8__andb byte (u1));
          is_zero_bit = ((Word8__toInt u2) = 0i);
        in
          ¬ is_zero_bit
        )
     in
       RawKey (Vector__tabulate (bytes_len * 8i) calc_at)
End

(* NEXT FUNCTION: (RawKey)
fun from_hex hex =
		from_bytes (Hex.hex_to_bytes hex);
*)
(* TODO! https://gitlab.com/InnoChain/node-ml/-/blob/feature/state-computer/primitive/utils/Hex.sml *)
(*
Definition Hex__hex_to_bytes_def:
  Hex__hex_to_bytes =
End
val _thm = translate _def;
Definition from_hex_def:
  from_hex hex =
    from_bytes (Hex__hex_to_bytes hex);
End
val _thm = translate _def;
val _v_def = (definition "_v_def");
*)

(* NEXT FUNCTION:
	fun to_string (RawKey v) =
		String.concat (List.map (fn b => if b then "1" else "0") (Vector.toList v));
*)

Definition RawKey__to_string_def:
  RawKey__to_string (x1:raw_key) : mlstring =
    case x1 of (RawKey v) =>
    (String__concat) ((List__map (λ b. if b then (strlit "1") else (strlit "0")) (Vector__toList v)))
End


(* NEXT FUNCTION:
	fun serialize (RawKey v) =
		Serialization.encode_list Serialization.encode_bool (Vector.toList v);
*)
(*
Definition RawKey__serialize_def:
  RawKey__serialize (RawKey v) =
    Serialization__encode_list Serialization__encode_bool (Vector__toList v)
End
*)

Definition RawKey__next_def:
  RawKey__next (r:raw_key) value : raw_key =
    RawKey__concat r (RawKey__from_items [value])
End



Definition RawKey__serialize_def:
  RawKey__serialize (RawKey v) =
    Serialization__encode_list (Serialization__encode_bool) (Vector__toList v)
End

Definition RawKey__deserialize_def:
  RawKey__deserialize bytes =
    let
      (lst, lst_len) = Serialization__decode_list Serialization__decode_bool bytes
    in
     (RawKey__from_items lst, lst_len)
End

val _ = export_theory ();
