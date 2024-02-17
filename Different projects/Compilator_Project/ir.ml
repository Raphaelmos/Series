module type VALUE = sig
  type t
end

module type IR = sig

  type ident
  type expr 
  type instr
  type func  
  type program

  val int : int VALUE.t
  val bool : bool VALUE.t

  val value : VALUE.t -> expr
  val var : ident -> expr
  val call : ident -> expr list -> expr

  val decl : ident -> instr
  val return : expr -> instr
  val expr : expr -> instr
  val assign : ident -> expr -> instr

  val cond : expr -> block -> block -> instr
  val while : expr -> block -> instr
  val block : instr list -> instr

  and block = instr list

  and func = 
    { args : ident list
    ; ret : VALUE.t
    ; body : block
    }

  and program = func list

end

module Make(V:VALUE) : IR = struct

  type ident = string

  type expr = 
    | Value of V.t
    | Var of ident
    | Call of ident * expr list

  type instr =
    | Decl of ident
    | Return of expr
    | Expr of expr 
    | Assign of ident * expr
    | Cond of expr * block * block
    | While of expr * block 
    | Block of instr list

  and block = instr list

  type func =
    { args : ident list
    ; ret : V.t
    ; body : block
    }

  type program = func list

  let int = int
  let bool = bool

  let value v = Value v
  let var i = Var i
  let call f args = Call(f,args)

  let decl i = Decl i
  let return e = Return e
  let expr e = Expr e
  let assign i e = Assign(i,e)

  let cond e t f = Cond(e,t,f) 
  let while e b = While(e,b)
  let block ins = Block ins

end

