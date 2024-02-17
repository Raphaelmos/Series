open Ast
open Lexing
open Parser
open Mips

module Error = struct
  exception Error of string
  exception SyntaxError of string
  exception TypeError of string * Lexing.position

let expr_pos expr =
  match expr with
  | Syntax.Int n  -> n.pos
  | Syntax.Var v  -> v.pos
  | Syntax.Call c -> c.pos

let errt expected given pos =
  raise (Error (Printf.sprintf "expected %s but given %s"
                  (string_of_type_t expected)
                  (string_of_type_t given),
                pos))


  let syntax_error msg =
    Printf.eprintf "Syntax error: %s\n" msg;
    raise (SyntaxError msg)

  let type_error (msg,pos) =  
    Printf.eprintf "Type error at line %d, column %d: %s\n"  
      pos.pos_lnum (pos.pos_cnum - pos.pos_bol) msg;
    raise (TypeError (msg,pos))

let rec string_of_type = function
  | Int_t -> "int"
  | Str_t -> "str" 
  | Bool_t -> "bool"
  | Func_t(ret, args) ->
     let args_str =  
       (match args with
        | [] -> ""
        | _ -> "(" ^ (String.concat ", " (List.map string_of_type args)) ^ ")")
     in
     args_str ^ " -> " ^ string_of_type ret

  let type_mismatch expected given pos =
    let expected_str = String.concat " or " (List.map string_of_type expected) in 
    let given_str = string_of_type given in
    type_error (Printf.sprintf "Expected %s but got %s" expected_str given_str, pos)

end

module Warning = struct

  let warning msg pos =
    Printf.eprintf "Warning at line %d, column %d: %s\n"  
      pos.pos_lnum (pos.pos_cnum - pos.pos_bol) msg

end