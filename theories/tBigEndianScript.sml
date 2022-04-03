(*path to the original file node-ml/primritive/utils/BigEndian.sml*)
open basis
open tIntTheory
open tListTheory
open tWord8Theory
open tWord64Theory
open tWord8ArrayTheory
open tByteArrayTheory
open MarshallingTheory
open ml_monad_translator_interfaceLib

val _ = new_theory "tBigEndian";

(** This function not working properly **)
(*fun int8byte8 value = 
		let
			val serialized = Word64.fromInt value 
			val result = List.genlist (fn index => 
				(Word8.fromInt (Word64.toInt (Word64.andb (Word64.fromInt 255) (Word64.>> serialized (8 * index)))))) 8
		in
			ByteArray.from_list (List.rev result)
		end;*)
           
Definition BigEndian__int8byte8_def:
  BigEndian__int8byte8 (value:int) =
  let
    serialized = (Word64__fromInt value);
    result = GENLIST (λ index. Word8__fromInt ( Word64__toInt ( Word64__andb ( Word64__fromInt 255 ) (Word64__lshift serialized  8)))) 8
  in
    ByteArray__from_list (result)
End

        
(*                               
fun byte8int8 bytes = 
		let
			val byte_list = ByteArray.to_list bytes
		in
			List.foldl (fn result => fn item => (256 * result + (Word8.toInt item))) 0 byte_list
		end; *)


Definition BigEndian__byte8int8_def:
  BigEndian__byte8int8 bytes =
  let
    byte_list = ByteArray__to_list bytes
  in
    FOLDL (λ (result : int). λ (item : word8). (256 * result + ( Word8__toInt item ))) 0i byte_list
End

(* fun int2byte2 value = 
		let
			val result = Word8Array.array 2 (Word8.fromInt 0)
		in
			(Marshalling.n2w2 value result 0; result)
		end; *)

Definition BigEndian__int2byte2_def:
  BigEndian__int2byte2 value = n2w2 value
End
        
(*	fun byte2int2 bytes = 
		Marshalling.w22n bytes 0; *)

Definition BigEndian__byte2int2_def:
  BigEndian__byte2int2 bytes = w22n bytes
End
        
(*
		fun w4n2 bytes off =
        	let 
			val b3 = Word8Array.sub bytes off
			val b2 = Word8Array.sub bytes (off+1)
			val b1 = Word8Array.sub bytes (off+2)
			val b0 = Word8Array.sub bytes (off+3)
		in
			Word8.toInt b3 * 256 * 256 * 256 + Word8.toInt b2 * 256 * 256 + Word8.toInt b1 * 256 + Word8.toInt b0
        end;
*)
Definition BigEndian__w4n2_def:
  BigEndian__w4n2 bytes off =
  let
    b3 = ( Word8Array__sub bytes off );
    b2 = ( Word8Array__sub bytes (off+1) );
    b1 = ( Word8Array__sub bytes (off+2) );
    b0 = ( Word8Array__sub bytes (off+3) );
  in
    Word8__toInt b3 * 256 * 256 * 256 + Word8__toInt b2 * 256 * 256 + Word8__toInt b1 * 256 + Word8__toInt b0
End
        (*

        fun n2w4 n bytes off =
        let
            val a = Word8Array.update bytes off     (Word8.fromInt (n div (256 * 256 * 256)))
            val a = Word8Array.update bytes (off+1) (Word8.fromInt (n div (256 * 256)))
            val a = Word8Array.update bytes (off+2) (Word8.fromInt (n div 256))
            val a = Word8Array.update bytes (off+3) (Word8.fromInt n)
        in 
            ()
        end;
end; *)

Definition BigEndian__n2w4_def:
  BigEndian__n2w4 n bytes off =
  let
        a = Word8Array__update bytes off         (Word8__fromInt (n % (256 * 256 * 256)));
        a = Word8Array__update bytes (off + 1)   (Word8__fromInt (n % (256 * 256)));
        a = Word8Array__update bytes (off + 2)   (Word8__fromInt (n %  256));
        a = Word8Array__update bytes (off + 3)   (Word8__fromInt n);
        in
        ()
End


val _ = export_theory ();
