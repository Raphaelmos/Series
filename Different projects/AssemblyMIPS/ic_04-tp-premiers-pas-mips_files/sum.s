.text
.globl main

main:


li $v0, 4
la $a0, prompt
syscall

li $v0, 5
syscall
move $t0, $v0 
li $t1, 0
li $t2, 1

loop:
bge $t2, $t0, end_loop # Si sortie de boucle
add $t1, $t1, $t2
addi $t2, $t2, 1
j loop
end_loop:

li $v0, 4
la $a0, result
syscall

move $a0, $t1
li $v0, 1
syscall

jr $ra

.data
prompt: .asciiz "Entrez la valeur de n: "
result: .asciiz "La somme est: "