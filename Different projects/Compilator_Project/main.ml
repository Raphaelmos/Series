open Lexing
(* open Ast *)
(* open Baselib *)


let file = "prog.s"


let err msg pos =
  Printf.eprintf "Error on line %d col %d: %s !!\n"
    pos.pos_lnum (pos.pos_cnum - pos.pos_bol) msg ;
  exit 1

let () =
  if (Array.length Sys.argv) != 2 then begin
      Printf.eprintf "Usage: %s <file>\n" Sys.argv.(0) ;
      exit 1
    end;
  let f = open_in Sys.argv.(1) in
  let buf = Lexing.from_channel f in
  try
    let parsed = Parser.start Lexer.token buf in
    close_in f ;
    Printf.eprintf "Analyze Syntax ...\n" ;

    let ast, env = Semantics.analyze parsed in
    Printf.eprintf "Constructed Semantics ...\n" ;

    let simplified = Simplifier.simplify ast in
    Printf.eprintf "Optimization ...\n" ;

    let asm = Compiler.compile simplified env in
    Printf.eprintf "Compiler loaded ...\n" ;
    
    let oc =  open_out file in
    Mips.emit oc asm ;
    Printf.eprintf "Built Successfully !\n" ;
  with
  | Lexer.Error c ->
     err (Printf.sprintf "Unrecognized char '%c'" c) (Lexing.lexeme_start_p buf)
  | Parser.Error ->
     err "Syntax Error" (Lexing.lexeme_start_p buf)
  | Semantics.Error (msg, pos) ->
     err msg pos
