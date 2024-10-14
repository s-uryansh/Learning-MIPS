.data
in_file: .asciiz "input.txt"
out_file: .asciiz "output.txt"
buf: .space 1024
nl: .asciiz "\n"

.text
start:
    li $v0, 13
    la $a0, in_file
    li $a1, 0
    li $a2, 0
    syscall
    move $t0, $v0

    li $v0, 14
    move $a0, $t0
    la $a1, buf
    li $a2, 1024
    syscall
    move $t1, $v0

    li $v0, 16
    move $a0, $t0
    syscall

    # Parsing and counting logic goes here

    # Sorting logic goes here

    li $v0, 13
    la $a0, out_file
    li $a1, 577
    li $a2, 438
    syscall
    move $t2, $v0

    # Writing logic goes here

    li $v0, 16
    move $a0, $t2
    syscall

    li $v0, 10
    syscall