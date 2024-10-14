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
	sw $v0, 0($sp)#stack pointer used for  storing and loading result temp
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
