Name: Suryansh Rohil
Roll: 2310110314
snu id: sr738

======================================================================================
Q1:
[
.data

string: .ascii "Hello World\n"

.text

	li $v0 ,4
	la $a0 , string #printing string
	syscall
]
======================================================================================

======================================================================================
Q2:
[
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
]
======================================================================================

======================================================================================
Q3:
[

.data

var1: .word 10
var2: .word 20

newline: .ascii "\n"

.text
#loading value from var1 , var2
	lw $t0 ,var1
	lw $t1 ,var2
	
#performing addition and subtraction
	add $t2,$t1,$t0
	sub $t3,$t1,$t0

#printing value of t2 (addition of var2 and var1)
	li $v0 , 1
	move $a0 , $t2
	syscall
	
#adding endline
	li $v0 , 4
	la $a0 , newline
	syscall
	
#printing value of t3 (subtraction of var2 and var1)
	li $v0 , 1
	move $a0 , $t3
	syscall
	
	
]
======================================================================================

======================================================================================
Q4:
[
.data
intVar: .word 25 #set value to check
flag: .word 0
	
.text

main:
	lw $t0, intVar 
	lw $t1, flag
	
#checking for positive
	bgt $t0, 0, is_Positive
	
#checking for zero
	beq $t0, 0, is_Zero
	
#not positive + not zero
	li $t1, -1
	sw $t1, flag
	li $v0, 10
	syscall
	
is_Positive:
	li $t1, 1 
	sw $t1, flag
	li $v0, 10
	syscall
	
is_Zero:
	li $t1, 0
	sw $t1, flag
	li $v0, 10
	syscall
	
	
]
======================================================================================

======================================================================================
Q5:
[
.data:
num: .word 2#set value to check
flag: .word 0

.text: 

main:
	lw $t0, num
	lw $t1, flag
	rem $t2,$t0, 2#getting reminder b dividing  $t0 and 2 and saving it in $t2
	beq $t2, 0, is_Even # If value of $t2 is zero the program jumps to the label is_Even
	
#not even , than it is odd
	li $t1, 0
	sw $t1, flag
	li $v0, 10 # exit code
	syscall
	
is_Even: 
	li $t1, 1
	sw $t1, flag
	li $v0, 10# exit code
	syscall
	
]
======================================================================================

======================================================================================
Q6:
[
.data
number: .word 0
	
.text

main:
	li $t0, 25
	sw $t0, number #storing $t0 in number
	
	lw $t1, number 
	
	li $v0, 10
	syscall 
]
======================================================================================