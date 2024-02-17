# Compilator

This project of Programming a language is realized for a course specific and based on elements from practical work made along the semester.

This project implements a small programming language with the following elements:
# Understanding of how it functions 
Successful tests :

err-lex
err-syntax
Varint.test

Minimal language expectations
Basic types

    Integer
    Booleans
    Character strings

Basic library

    Read and write to standard input and output of basic types
    Basic Boolean logic operators (AND, OR, NOT)
    Basic integer arithmetic operators (addition, subtraction, multiplication, division, modulo)

Expressions

    Value
    Variable
    Function calls (from basic library or user-defined)

Instructions

    Variable declaration
    Assign the value of an expression to a variable
    Return the value of an expression
    Conditional branching "if expression then block else block".
    Loop "as long as expression do block".

Other elements

    A block is a sequence of instructions
    A program is a list of function definitions

# Compilation and testing
Using a build

dune build main.exe

or

ocamlbuild -use-menhir main.byte

Run tests

./main.exe tests/int.test
then
spim -file prog.s

Examples of tests

tests/AddInt.test
tests/AddVar.test
tests/DivInt.test
tests/DivVar.test
tests/MulInt.test
tests/MulVar.test
tests/MulVar2.test
tests/RemInt.test
tests/RemVar.test
tests/RemVar2. test





# French

Langage de programmation
Ce projet à été réaliser avec les éléments de TP fait pendant le semestre.
Ce projet implémente un petit langage de programmation avec les éléments suivants :

Tests ayant fonctionnés :

err-lex
err-syntax
Varint.test

Attendus minimaux du langage
Types de base

    Entiers
    Booléens
    Chaînes de caractères

Bibliothèque de base

    Lecture et écriture sur l'entrée et la sortie standard des types de bases
    Opérateurs logiques de base sur les booléens (ET, OU, NON)
    Opérateurs arithmétiques de base sur les entiers (addition, soustraction, multiplication, division, modulo)

Expressions

    Valeur
    Variable
    Appel de fonction (de la bibliothèque de base ou définie par l'utilisateur)

Instructions

    Déclaration de variable
    Assignation de la valeur d'une expression à une variable
    Renvoie de la valeur d'une expression
    Branchement conditionnel “si expression alors bloc sinon bloc”
    Boucle “tant que expression faire bloc”

Autres éléments

    Un bloc est une séquence d'instructions
    Un programme est une liste de définitions de fonctions

# Compilation et tests
Utiliser dune build

dune build main.exe

ou

ocamlbuild -use-menhir main.byte

Exécuter les tests

./main.exe tests/int.test
puis
spim -file prog.s

Exemples de tests

tests/AddInt.test
tests/AddVar.test
tests/DivInt.test
tests/DivVar.test
tests/MulInt.test
tests/MulVar.test
tests/MulVar2.test
tests/RemInt.test
tests/RemVar.test
tests/RemVar2.test

Et autres à voir dans le dossier tests
