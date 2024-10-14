.data
str: .asciiz "Factorial of 5 is: "
	
.text

main:
#loading temp registers
	li $t0, 5
	li $t1, 1
start:
#loop for factorial
	beq $t0, 0, return
	beq $t0, 1, return
	mul $t1, $t1, $t0 # t1 = t1 * t0 
	sub $t0, $t0, 1 # t0 = t0 -1 
	j start 
	
return:
	li $v0, 4
	la $a0, str
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
