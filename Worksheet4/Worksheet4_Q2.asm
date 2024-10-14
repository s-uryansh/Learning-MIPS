.data
num: .space 100
fac: .space 100
result: .asciiz "factorial: "
console: .asciiz "num: "
error: .asciiz "ERROR"

.text

	jal input_num
	jal factorial
	jal display
	
	li $v0 ,10
	syscall
	
input_num:
	li $v0 , 4
	la $a0 , console
	syscall
	
	li $v0 , 5
	syscall
	
	la $t0 , num
	sw $v0 , 0($t0) 
	
	jr $ra
factorial:
#loading num in a0 , handeling 0 and 1 case
	la $t0 , num
	lw $a0 ,0($t0)
	li $t1 , 1
	
	blt $a0 , $zero , error_fac
	beq $a0 , $t1 , fac_one
	li $t1 , 0
	beq $a0 , $t1 , fac_zero
#fac result to 1 and enters the loop
	li $t1 , 1
	move $t2 , $a0
	
	loop:
	#multiplies the result by counter and decrement until 0
		mul $t1 , $t1 ,$t2
		sub $t2 , $t2 , 1
		bgtz $t2 , loop
		
		la $t0 , fac
		sw $t1 , 0($t0)
		
		jr $ra
fac_one:
    li $v0, 1     
    la $t0, fac    
    sw $v0, 0($t0) 
    jr $ra       

fac_zero:
    li $v0, 1     
    la $t0, fac     
    sw $v0, 0($t0)
    jr $ra

error_fac:
    li $v0, 4
    la $a0, error
    syscall
    li $v0, 10
    syscall

display:
   	li $v0, 4
    	la $a0, result
    	syscall
    	
    	la $t0 , fac
    	lw $a0 , 0($t0)

    	li $v0, 1
    	syscall
    	
    	jr $ra