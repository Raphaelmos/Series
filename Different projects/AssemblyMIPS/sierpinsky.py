x = 1
while x < 2147483648: # = 2**31
    n = x
    while n > 0:
        if n & 1:
            print('#',end='') # end='' empêche l'ajout auto du \n
        else:
            print(' ',end='')
        n >>= 1
    print('')
    x ^= x << 1


""""
let rec print_binary n =
  if n = 0 then ()
  else (
    if n land 1 = 1 then print_string "#"
    else print_string " ";
    print_binary (n asr 1)
  )

let rec loop x =
  if x < 2147483648 then (
    let n = x in
    print_binary n;
    print_string "\n";
    loop (x lxor (x lsl 1))
  )

let _ =
  let x = 1 in
  loop x


"""


"""
.global main

main:
  mov eax, 1 ; x = 1

loop:
  cmp eax, 2147483648
  jge done

  push eax ; save x

  call print_binary
  add esp, 4 ; cleanup stack

  pop ebx ; x

  xor eax, ebx 
  shl eax, 1 ; x ^= x << 1

  jmp loop

print_binary:
  push ebp
  mov ebp, esp

  mov ebx, [ebp+8] ; n

print_loop:  
  and ebx, 1 ; n & 1 
  cmp ebx, 0
  je print_zero

  mov eax, '#'
  jmp print_char

print_zero:  
  mov eax, ' '

print_char:
  call print_char

  shr ebx, 1 ; n >>= 1

  test ebx, ebx
  jnz print_loop

  pop ebp
  ret

done:
  ret



"""