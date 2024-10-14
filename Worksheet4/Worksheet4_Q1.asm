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