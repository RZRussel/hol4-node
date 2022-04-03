open preamble
open ml_monad_translator_interfaceLib
open tIntProgTheory (*previous*)
open tBoolTheory

val _ = new_theory "tBoolProg";
val _ = m_translation_extends "tIntProg";

val Bool__compare_thm = translate Bool__compare_def;
(*
val Bool__True_thm = translate Bool__True_def;
val Bool__False_thm = translate Bool__False_def;
*)
val _ = export_theory ();

