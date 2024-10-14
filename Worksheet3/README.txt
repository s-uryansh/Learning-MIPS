
======================================================================================
* Q1:
[
.data
str: .asciiz "number: "
str2: .asciiz "number to be shifted by: "
	
.text

main:
#asking for number wanted
	li $v0, 4
	la $a0, str
	syscall
		
	li $v0, 5
	syscall
	move $t0, $v0
#asking for number to be shift
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
#shifting function
	sllv $t2, $t0, $t1
	
	move $a0, $t2
	li $v0, 1
	syscall
#exit
	li $v0, 10
	syscall
]

======================================================================================

======================================================================================
* Q2(1):
[
.data
str: .asciiz "number of rows needed: "
pattern: .asciiz "*"
newLine: .asciiz "\n"
	
.text

main:
#asking for number of rows
	li $v0, 4
	la $a0, str
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 #number of rows
#start 
	li $t1, 0
	j outside_loop
	
outside_loop:
	addi $t1, $t1, 1
	bgt $t1, $t0, out_loop_exit
	move $t2, $t1 #t2 is the number of stars in that row
	j inside_loop
	
inside_loop:
	ble $t2, 0, in_loop_exit
	
	li $v0, 4
	la $a0, pattern
	syscall
	
	sub $t2, $t2, 1
	j inside_loop
	
in_loop_exit:
	li $v0, 4
	la $a0, newLine
	syscall
	j outside_loop
	
out_loop_exit:
	li $v0, 10
	syscall
	
	

]

======================================================================================

======================================================================================
* Q2(2):
[

.data
str: .asciiz "number of rows needed: "
pattern: .asciiz "*"
gap: .asciiz " "
new_line: .asciiz "\n"
	
.text

main:
	li $v0, 4
	la $a0, str
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 0
	j out_loop
	
out_loop:
	addi $t1, $t1, 1
	bgt $t1, $t0, exit_out_loop
	
	sub $t3, $t0, $t1
	j add_gap
	
add_gap:
	blez $t3, out_loop_count
	
	li $v0, 4
	la $a0, gap
	syscall
	
	subi $t3, $t3, 1
	j add_gap
	
out_loop_count:
	add $t4, $t1, $t1
	subi $t4, $t4, 1
	
	j in_loop
	
in_loop:
	blez $t4, in_loop_exit
	
	li $v0, 4
	la $a0, pattern
	syscall
	
	subi $t4, $t4, 1
	j in_loop
	
in_loop_exit:
	li $v0, 4
	la $a0, new_line
	syscall
	
	j out_loop
	
exit_out_loop:
	li $v0, 10
	syscall

]
======================================================================================

======================================================================================
* Q3:
[
.data
first_input_str: .asciiz "first integer: "
second_input_str: .asciiz "second integer: "
new_line: .asciiz "\n"
	
out_product_str: .asciiz "Product: "
out_sum_str: .asciiz "Sum: "
out_sub_str: .asciiz "Difference: "
	
.text
.globl main

main:
#getting first number
	li $v0, 4
	la $a0, first_input_str
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0 # Store first input in $t0
#getting second nuber
	li $v0, 4
	la $a0, second_input_str
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0 # Store second input in $t1

	move $a0, $t0
	move $a1, $t1
#sum
	jal f_add
	sw $v0, 0($sp)
#product	
	jal f_prod
	sw $v0, -4($sp)
#difference
	jal f_sub
	sw $v0, -8($sp)
#product output
	li $v0, 4
	la $a0, out_product_str
	syscall
	
	lw $a0, -4($sp)
	li $v0, 1
	syscall
#next line
	li $v0, 4
	la $a0, new_line
	syscall
#sum output
	li $v0, 4
	la $a0, out_sum_str
	syscall
	
	lw $a0, 0($sp)
	li $v0, 1
	syscall
#next line
	li $v0, 4
	la $a0, new_line
	syscall
#difference output
	li $v0, 4
	la $a0, out_sub_str
	syscall
	
	lw $a0, -8($sp)
	li $v0, 1
	syscall
#next line
	li $v0, 4
	la $a0, new_line
	syscall

	li $v0, 10
	syscall
			
f_add:
	add $v0, $a0, $a1
	jr $ra
	
f_prod:
	mul $v0, $a0, $a1
	jr $ra

f_sub:
	sub $v0, $a0, $a1
	jr $ra
]
======================================================================================

======================================================================================
* Q4:
[
.data
str: .asciiz "enter integer to convert: "
binary: .space 33  

.text
main:
# Print string and read integer
    la $a0, str
    li $v0, 4
    syscall
# Store input integer in $t0
    li $v0, 5
    syscall
    move $t0, $v0  

# Check if integer is negative
    blt $t0, $zero, negative
    j positive

negative:
# Calculate 2's complement
    li $t1, -1
    xor $t0, $t0, $t1
    addi $t0, $t0, 1

positive:
# Converting
    la $a0, binary
    li $t1, 31 
loop:
    andi $t2, $t0, 1
    beq $t2, $zero, zero
    li $t2, '1'
    j store
zero:
    li $t2, '0'
store:
    sb $t2, 0($a0)
    addi $a0, $a0, 1
    srl $t0, $t0, 1
    addi $t1, $t1, -1
    bgt $t1, $zero, loop

# Null-terminate binary string
    li $t2, 0
    sb $t2, 0($a0)

# Print binary string
    la $a0, binary
    li $v0, 4
    syscall

# Exit
    li $v0, 10
    syscall
]
======================================================================================

======================================================================================
* Q5:
[
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
]
======================================================================================

======================================================================================
* Q6:
[

.data
str: .asciiz "madame"
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
]
======================================================================================

======================================================================================