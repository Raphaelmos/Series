open Ast

module type IR_SIG = sig

  type prog 
  type expr
  type value

  val prog : prog
  val expr : expr -> expr
  val value : value -> value

  type ident
  type instr  
  type func

  val ident : string -> ident
  val instr : instr -> instr  
  val func : func -> func

end

module Simplifier (I : IR_SIG) = struct

  type context = {
    constants : I.value Constant.Map.t;
    env : Env.t
  }

  let simplify (prog : I.prog) : I.prog =
    let ctx = init_context () in  
    visit prog ctx

  and visit : I.node -> context ->  I.node =
   fun node ctx ->
     match node with
    | I.Expr e ->
       let e' = visit_expr e ctx in  
       I.expr e'

    | I.Value v ->  
       let v' = simplify_value v ctx in
       I.value v'
    
    | I.Var id -> 
     I.ident id

    | I.Instr i ->
      let i' = visit_instr i ctx in
      I.instr i'

    | I.func f ->  
      let f' = visit_func f ctx in
      I.func f'

  and visit_instr : I.instr -> context -> I.instr =
    | I.Assign(x, e) ->  
       let e' = visit_expr e ctx in
       I.assign(x, e')

    | I.Block ins ->
       let ins' = List.map (visit_instr) ins in  
       I.block ins'

    and visit_func (f: I.func) ctx =
    let body' = List.map (visit_instr) f.body in
    {
      params = f.params;
      body = body';
    }

  and simplify_value : I.value -> context -> I.value = function
    | Int i ->
      if Constant.mem i ctx.constants then  
        Constant.find i ctx.constants  
      else
        let c = Int i in   
        Constant.add c ctx.constants;
        c
      
    | Str s ->
      if Constant.mem_string s ctx.constants then
        Constant.find_string s ctx.constants  
      else
        let c = Str s in
        Constant.add_string c ctx.constants;
    	c

module SimplifierTests = struct
(* tests *)
  let%test "constant folding" = 
    let prog = [Int 1; Add(Int 1, Int 2)] in
    match simplify prog with
    | Some [Int 3] -> true
    | _ -> false

let%test "identity on single value" =
  let prog = [Int 1] in  
  match simplify prog with
  | Some [Int 1] -> true
  | _ -> false

let%test "noop on variable" =
  let prog = [Var "x"] in
  match simplify prog with
  | Some [Var "x"] -> true
  | _ -> false

let%test "constant propagation" =
  let prog = [Assign("x", Int 1); Add(Var "x", Int 2)] in
  match simplify prog with
  | Some [Int 3] -> true
  | _ -> false

let%test "dead code elimination" =
  let prog = [Int 1; Nop; Int 2] in
  match simplify prog with
  | Some [Int 1; Int 2] -> true
  | _ -> false

let%test "function inlining" =
  let func = { params = []; body = [Int 1] }
  and prog = [Call("f", [])] 
  in
  match simplify (func func) with
  | Some [Int 1] -> true
  | _ -> false

end


and init_context () = 
    {constants = Constant.Map.empty; env = Env.empty}

end

module B1 = Simplifier(IR1)
module B2 = Simplifier(IR2) 

module IR1 : IR_SIG = struct

  type prog = Expr list

  and expr = 
    | Int of int
    | Add of expr * expr

  type value = 
    | IntValue of int

  type ident = string

  type instr =
    | Assign of ident * expr
    | Block of instr list  

  type func = {
    params : ident list;
    body : instr; 
  }

  let prog p = p

  let expr e = e

  let value v = v

  let ident id = id

  let instr i = i

  let func f = f

end

module IR2 : IR_SIG = struct

  type prog = func of func

  type expr =
    | Id of ident
    | Call of ident * expr list

  type value = 
    | IntValue of int 
    | funcValue of func

  type ident = string

  type instr =
    | Assign of ident * expr
    | Block of instr list  

  type func = {
    params : ident list;
    body : instr; 
  }


  let prog p = p

  let expr e = e

  let value v = v

  let ident id = id

  let instr i = i

  let func f = f

end