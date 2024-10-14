======================================================================================
* Q1.
[
.data
str: .space 100
revStr: .space 100
console: .asciiz "string to reverse: "

.text

	jal readStr #reads the string from user
	
	jal strlen #getting the length of string given by uuser
	
	add $t1, $zero, $v0 #stores the length of string in t1	
	add $t2, $zero, $a0 #stores the address of input string in t2
		
	jal reverse #reversing the input string
	
	jal display #displaying the reversed string
	
	
	
readStr:
	li $v0 , 4 #code to print string
	la $a0 , console
	syscall
	
	li $v0 ,8 #code to read string
	la $a0 , str
	li $a1 , 100 #limiting string to 100 char
	syscall
	
	jr $ra #return to the caller
	
reverse:
	li $t0, 0 #counter = 0	
	li $t3, 0 #ptr to start of string		
	
	reverse_loop: #reversing
		add $t3, $t2, $t0 #addr of current char		
		lb $t4, 0($t3)	#load current char in t4
		beqz $t4, display #if null char display 
		sb $t4, revStr($t1) #storing the current char 
		subi $t1, $t1, 1 #position counter -1
		addi $t0, $t0, 1 #t0 counter +1		
		j reverse_loop	
	jr $ra #return to caller
	
display:
	li $v0, 4 
	la $a0, revStr
	syscall
	li $v0 ,10
	syscall
	
strlen:
	li $t0, 0 #counter = 0
	li $t2, 0 #ptr to start of string
	#going through the whole string
	strlen_loop:
		add $t2, $a0, $t0 #calculate the address of current character
		lb $t1, 0($t2) #load current char in t1
		beqz $t1, strlen_exit #if char is null exits the loop
		addiu $t0, $t0, 1 #counter+1
		j strlen_loop
		
	strlen_exit:
		subi $t0, $t0, 1 #-1 to exclude the null character
		add $v0, $zero, $t0 #storing length in v0
		add $t0, $zero, $zero #counter reset
		jr $ra #return to caller
]
======================================================================================

======================================================================================
* Q2.
[
.data
num: .space 100
fac: .space 100
result: .asciiz "factorial: "
console: .asciiz "num: "

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
        	
display:
   	li $v0, 4
    	la $a0, result
    	syscall
    	
    	la $t0 , fac
    	lw $a0 , 0($t0)

    	li $v0, 1
    	syscall
    	
    	jr $ra
]
======================================================================================

======================================================================================
* Q3.
[
.data

arr: .space 20
str: .asciiz "enter size of arr: "
str1: .asciiz "enter element : "
max: .asciiz "max element is: "
newline: .asciiz "\n"

.text

   
    jal get_arr
    jal find_max
    jal display
    
    li $v0, 10
    syscall

get_arr:
#asking for size of the array 
    li $v0, 4
    la $a0, str
    syscall
    
  
    li $v0, 5
    syscall
    move $s0, $v0               
    
    la $t0, arr                
    li $t1, 0 #counter = 0     
    
loop:
    beq $t1, $s0, end #if counter is equal to size of array jumps to end
 
 #asking for element of array
    li $v0, 4
    la $a0, str1
    syscall
    
    li $v0, 5
    syscall
    
#store the read int to current index
    sw $v0, 0($t0)
    addi $t0, $t0, 4          
    addi $t1, $t1, 1          
    j loop                  
    
end:
    jr $ra                

find_max:
    la $t0, arr            
    lw $t1, 0($t0)   
    li $t2, 1 #counter = 1
    
loop1:
#goes through whole array taking current element as max and comparing for bigger element
    beq $t2, $s0, end1
    lw $t3, 0($t0)             
    blt $t1, $t3, updateMax  
    addi $t0, $t0, 4          
    addi $t2, $t2, 1         
    j loop1                   
    
end1:
    move $s1, $t1 #moves the max in s1 
    jr $ra          

updateMax:
    move $t1, $t3       
    j loop1           

display:
   
    li $v0, 4
    la $a0, max
    syscall
    
   
    li $v0, 1
    move $a0, $s1
    syscall
    
 
    li $v0, 4
    la $a0, newline
    syscall
    
    jr $ra                     
]
======================================================================================