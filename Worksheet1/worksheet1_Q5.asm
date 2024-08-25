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
	
	
