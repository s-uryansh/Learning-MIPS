.data
number: .word 0
	
.text

main:
	li $t0, 25
	sw $t0, number #storing $t0 in number
	
	lw $t1, number 
	j print
	
	li $v0, 10
	syscall 
	
print:
	li $v0 ,1
	lw $a0 ,number
	syscall
