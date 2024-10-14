.data
str: .asciiz "   "
palindrome: .asciiz "palindrome"
not_palindrome: .asciiz "not a palindrome"

.text
main:
    la $t0, str
    la $t1, str

    # Find the length of the string
    loop_length:
        lb $t2, 0($t1)
        beq $t2, $zero, loop_end
        addi $t1, $t1, 1
        j loop_length
    loop_end:
    sub $t1, $t1, 1

    # Compare characters pairwise until the middle of the string
    loop:
        lb $t2, 0($t0)
        lb $t3, 0($t1)

        beq $t2, $t3, continue
        j not_palindrome_found

    continue:
        addi $t0, $t0, 1
        addi $t1, $t1, -1

        blt $t0, $t1, loop

    la $a0, palindrome
    j print_result

not_palindrome_found:
    la $a0, not_palindrome
    j print_result

print_result:
    li $v0, 4
    syscall

    li $v0, 10
    syscall
