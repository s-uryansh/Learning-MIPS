.data

str: .asciiz "Sum of even numbers from 1 to 10: "
	
.text

main:
#loading t0 , t1 and t2
	li $t0, 0
	li $t1, 5
	li $t2, 1
	
start:
#loop
	bgt $t1,0, end
	
	div  $t1, $t2
	mfhi $t3 #moving t3 from high to genral purpose register (used to recieve reminder from division operation)
	beq $t3, 0, operation
	
	addi $t1, $t1, 1
	j start #goes back to start for loop

operation:
#add operation
	add $t0, $t0, $t1 #t0 = t0 + t1
	
	addi $t1, $t1, 1#adding immediat value 1 to t1
	j start
	
end:
#loop end
	li $v0, 4
	la $a0, str#printing string 
	syscall
	
	move $a0, $t0#setting value of t0 to a0
	li $v0, 1#printingg num out
	syscall
	
	li $v0, 10#exiting loop
	syscall
	
