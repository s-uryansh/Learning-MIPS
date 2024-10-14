
======================================================================================
* Q1:
[
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
	beqz $t0,isZero
	bgt $t0 , 0 , isPositive
	j isNegative
	
isZero:
	la $a0 , txtZero
	li $v0 , 4
	syscall
	j exit
	
isPositive:
	la $a0 , txtPositive
	li $v0 , 4
	syscall
	j exit
	
isNegative:
	la $a0 , txtNegative
	li $v0 , 4
	syscall
	j exit

exit:
	li $v0 , 10
	syscall
]

======================================================================================

======================================================================================
* Q2:
[
.data

num1Str: .asciiz "Enter first numebr: "
err .asciiz "Invalid operation"
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
        div $t3, $t0, $t1
        j print_result

error_label:
        # Print error message
        li $v0, 4
        la $a0, err
        syscall	
        
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
]

======================================================================================

======================================================================================
* Q3:
[

.data

str: .asciiz "Sum of even numbers from 1 to 10: "
	
.text

main:
#loading t0 , t1 and t2
	li $t0, 0
	li $t1, 1
	li $t2, 2
	
start:
#loop
	bgt $t1, 10, end
	
	div  $t1, $t2
	mfhi $t3
	beq $t3, 0, operation
	
	addi $t1, $t1, 1
	j start

operation:
#add operation
	add $t0, $t0, $t1
	
	addi $t1, $t1, 1
	j start
	
end:
#loop end
	li $v0, 4
	la $a0, str
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
		
	
]
======================================================================================

======================================================================================
* Q4:
[
.data
str: .asciiz "Factorial of 5 is: "
	
.text

main:
#loading
	li $t0, 5
	li $t1, 1
start:
#loop for factorial
	beq $t0, 0, return
	beq $t0, 1, return
	mul $t1, $t1, $t0
	sub $t0, $t0, 1
	j start 
	
return:
	li $v0, 4
	la $a0, str
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
]
======================================================================================

======================================================================================
* Q5:
[
.data
str: .asciiz "Fibonacci Series up to 10 terms: "
gap: .asciiz " "
	
.text

main:
#loading 
	li $t0, 10
	li $t1, 0 
	li $t2, 1 
	li $t4, 0 
	
start:
	bgt $t4, $t0, end
	
	ble $t4, 1, print_nxt
	add $t3, $t1, $t2
	move $t1, $t2
	move $t2, $t3
	
	move $a0, $t3
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, gap
	syscall
	
	addi $t4, $t4, 1
	j start
	
print_nxt:
	move $a0, $t4
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, gap
	syscall
	
	addi $t4, $t4, 1
	j start
	
end:
	li $v0, 10
	syscall
]
======================================================================================

======================================================================================
