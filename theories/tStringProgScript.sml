open preamble
open ml_monad_translator_interfaceLib
open tWord8ArrayProgTheory (*previous*)
open tStringTheory

val _ = new_theory "tStringProg";
val _ = m_translation_extends "tWord8ArrayProg";

val String__size_thm = translate String__size_def;
val String__sub_thm = translate String__sub_def;
val String__implode_thm = translate String__implode_def;
val String__concat_thm = translate String__concat_def;

val _ = export_theory ();

