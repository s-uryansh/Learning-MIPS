.data

console: .asciiz "Enter value for n: "
txtZero: .asciiz "Entered number is zero"
txtPositive: .asciiz "Entered number is positive"
txtNegative: .asciiz "Entered number is negative"

.text

#asking user to enter n
	la $a0 , console
	li $v0 , 4
	syscall
	
#taking input from user (system code 5 to take input)
	li $v0 , 5
	syscall
	
#storing value from user to $t0 
	move $t0 , $v0
#checking for +ve, -ve , 0

check:
	beqz $t0,isZero #if equal to zero goes to label isZero
	bgt $t0 , 0 , isPositive #if greater than 0 goes to label isPositive 
	j isNegative#if none of above goes to label isNegative
	
isZero:#printing that number is zero
	la $a0 , txtZero
	li $v0 , 4
	syscall
	j exit
	
isPositive:#printing that number is +ve
	la $a0 , txtPositive
	li $v0 , 4
	syscall
	j exit
	
isNegative:#printing that number is -ve
	la $a0 , txtNegative
	li $v0 , 4
	syscall
	j exit

exit:
	li $v0 , 10
	syscall
