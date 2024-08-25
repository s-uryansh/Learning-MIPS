.data
var1: .word 10
var2: .word 7
str : .ascii "\n"

.text
	lw $s0 , var1
	lw $s1 , var2
	
	li $v0, 1 #system code for integer: 1
	move $a0, $s0 #copying value of "$s0" to "$a0" to print it out 
	syscall
	
	
	li $v0 , 4 #system code for string: 4
	la $a0 , str #copying value of "str" to "$a0" to print it out 
	syscall

	li $v0, 1 #system code for integer: 1
	move $a0, $s1 #copying value of "$s1" to "$a0" to print it out 
	syscall
	
	li $v0 , 4 #system code for string: 4
	la $a0 , str #copying value of "str" to "$a0" to print it out
	syscall 

# Swapping both var wihtout introducing 3rd var
	add $s0, $s0, $s1
	sub $s1, $s0, $s1
	sub $s0, $s0, $s1

# Saving new values
	sw $s0, var1
	sw $s1, var2

	li $v0, 1 #system code for integer: 1
	lw $a0, var1 #loding value of variable "var1"
	syscall
	
	li $v0 , 4 #system code for string: 4
	la $a0 , str #copying value of "str" to "$a0" to print it out
	syscall

	li $v0, 1 #system code for integer: 1
	lw $a0, var2 #loding value of variable "var2"
	syscall
	
	li $v0 , 4 #system code for string: 4
	la $a0 , str #copying value of "str" to "$a0" to print it out
	syscall