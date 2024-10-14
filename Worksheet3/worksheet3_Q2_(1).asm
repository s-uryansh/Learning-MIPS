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
	
	
