

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

Compilation et tests
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