.data
intVar: .word 10#set value to check
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
	j print
	li $v0, 10
	syscall
	
is_Positive:
	li $t1, 1 
	sw $t1, flag
	j print
	li $v0, 10
	syscall
	
is_Zero:
	li $t1, 0
	sw $t1, flag
	j print
	li $v0, 10
	syscall
	
	
print:
	li $v0 ,1
	lw $a0 ,flag
	syscall