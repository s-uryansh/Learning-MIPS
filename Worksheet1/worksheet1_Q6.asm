.data
number: .word 0
	
.text

main:
	li $t0, 25
	sw $t0, number #storing $t0 in number
	
	lw $t1, number 
	
	li $v0, 10
	syscall 