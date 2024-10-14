.data

num1Str: .asciiz "Enter first numebr: "
error: .asciiz "Invalid operation"
err_zero: .asciiz "\nInvalid number"
result: .asciiz "\nResult: "
num2Str: .asciiz "Enter second numebr: "
oprStr: .asciiz "Enter Operation (+ , - , / , * ): "

.text

#asking for num1 
	li $v0 , 4
	la $a0 , num1Str
	syscall
	
#getting num1
	li $v0, 5
       	syscall
        	move $t0, $v0
	
#asking for num2
	li $v0 , 4
	la $a0 , num2Str
	syscall
	
#getting num2
	li $v0, 5
       	syscall
        	move $t1, $v0
        	
        	
#asking for operation
	li $v0, 4
	la $a0, oprStr
	syscall
#getting the operation
	li $v0, 12 #code to read character
	syscall
	move $t2, $v0
	
#checking which operation to do
	beq $t2, '+', add
	beq $t2, '-', sub
	beq $t2, '*', mul
	beq $t2, '/', div
	j error_label


add:
        # Perform addition
        add $t3, $t0, $t1
        j print_result

sub:
        # Perform subtraction
        sub $t3, $t0, $t1
        j print_result

mul:
        # Perform multiplication
        mul $t3, $t0, $t1
        j print_result

div:
    # Perform division
    beq $t1 ,$zero , errZero
        div $t3, $t0, $t1
        j print_result

error_label:
        # Print error message
        li $v0, 4
        la $a0, error
        syscall
        j exit
errZero:
        li $v0 , 4
        la $a0 , err_zero
        syscall	
        j exit
        
print_result:
        li $v0, 4
        la $a0, result
        syscall

        # Print the result
        li $v0, 1
        move $a0, $t3
        syscall
 
exit:
        # Exit the program
        li $v0, 10
        syscall
