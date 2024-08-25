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
	
	