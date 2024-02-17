open Ast

module Env = Map.Make(String)
module Pile = Stack
let _types_ = 
    List.fold_left
        (fun env (pris, typ) -> Env.add pris typ env)
        Env.empty
        [ "_add",  Func_t (Int_t , [ Int_t ; Int_t ])
         ;"_sub",  Func_t (Int_t , [ Int_t ; Int_t ])
         ;"_mul",  Func_t (Int_t , [ Int_t ; Int_t ])
         ;"_div",  Func_t (Int_t , [ Int_t ; Int_t ])
         ;"_mod",  Func_t (Int_t , [ Int_t ; Int_t ])
         ;"puti",  Func_t (Nil_t , [ Int_t])
         ;"puts",  Func_t (Nil_t , [ Str_t])
         ;"putb",  Func_t (Nil_t , [ Bool_t])
         ;"putnl", Func_t (Nil_t , [ ])
         ;"geti",  Func_t (Int_t , [ ])
         ;"exit",  Func_t (Nil_t , [ ])
         ;"_eq" ,  Func_t (Bool_t, [ Int_t ; Int_t ])
         ;"_neq",  Func_t (Bool_t, [ Int_t ; Int_t ])
         ;"_sll" ,  Func_t (Int_t, [ Int_t ; Int_t ])
         ;"_srl",   Func_t (Int_t, [ Int_t ; Int_t ])
         ;"_gt" ,  Func_t (Bool_t, [ Int_t ; Int_t ])
         ;"_gte",  Func_t (Bool_t, [ Int_t ; Int_t ])
         ;"_lt" ,  Func_t (Bool_t, [ Int_t ; Int_t ])
         ;"_lte",  Func_t (Bool_t, [ Int_t ; Int_t ])
         ;"_or" ,  Func_t (Bool_t, [ Bool_t ; Bool_t ])
         ;"_and",  Func_t (Bool_t, [ Bool_t ; Bool_t ])
         ;"_xor",  Func_t (Int_t , [ Int_t ; Int_t ])
         ;"_not",  Func_t (Bool_t, [ Int_t])
        ]

