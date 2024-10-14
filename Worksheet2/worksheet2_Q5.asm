.data
str: .asciiz "Fibonacci Series up to 10 terms: "
gap: .asciiz " "
	
.text

main:
#loading temp registers
	li $t0, 10
	li $t1, 0 
	li $t2, 1 
	li $t4, 0 
	
start:
	bgt $t4, $t0, end #if t4 is greater than t0 goes to label end
	
	ble $t4, 1, print_nxt # if t4 is less or equal to 1 goes to printing next label
	#operations
	add $t3, $t1, $t2 # t3 = t1 + t2
	move $t1, $t2 #setting value of t2 in t1
	move $t2, $t3 #setting value of t3 in t2
	
	move $a0, $t3 #setting value of t3 in 0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, gap #printing space
	syscall
	
	addi $t4, $t4, 1#adding immediate value of 1 to t4 
	j start#goes back to start
	
print_nxt:
	move $a0, $t4 #setting value of t4 in a0
	li $v0, 1 #printing it out
	syscall
	
	li $v0, 4
	la $a0, gap #printing space b/w numbers
	syscall
	
	addi $t4, $t4, 1#adding immediate value of 1 to t4
	j start
	
end:
	li $v0, 10
	syscall
