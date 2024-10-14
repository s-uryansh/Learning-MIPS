.data
age_str:    .asciiz "age: "
id_str:     .asciiz "1 if you have a voter ID card, 0 if not: "
eligible_str:  .asciiz "You are eligible to vote."
not_eligible_str: .asciiz "You are not eligible to vote."

.text
main:
    li $v0, 4
    la $a0, age_str
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    blt $t0, 18, notEligible

    li $v0, 4
    la $a0, id_str
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    beq $t1, 1, eligible

    j notEligible

eligible:
    li $v0, 4
    la $a0, eligible_str
    syscall
    j exit

notEligible:
    li $v0, 4
    la $a0, not_eligible_str
    syscall

exit:
    li $v0, 10
    syscall
