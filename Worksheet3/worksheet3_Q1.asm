.data
str: .asciiz "number: "
str2: .asciiz "number to be shifted by: "
	
.text

main:
#asking for number wanted
	li $v0, 4
	la $a0, str
	syscall
		
	li $v0, 5
	syscall
	move $t0, $v0
#asking for number to be shift
	li $v0, 4
	la $a0, str2
	syscall
	
	li $v0, 5
	syscall
	move $t1, $v0
#shifting function
	sllv $t2, $t0, $t1
	
	move $a0, $t2
	li $v0, 1
	syscall
#exit
	li $v0, 10
	syscall
