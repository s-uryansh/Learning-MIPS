.data
inputFileName: .asciiz "input.txt"
outputFileName: .asciiz "output_Q3.txt"
buffer: .space 4096

.text
.globl main
main:
	li $v0, 13
	la $a0, inputFileName
	li $a1, 0
	li $a2, 0
	syscall
	move $s0, $v0
	la $a0, inputFileName								
	li $a1, 0												
	li $a2, 0				
	syscall
	move $s0, $v0								
	
	li $v0, 14		
	move $a0, $s0								
	la $a1, buffer											
	li $a2, 4096			
	syscall
	move $s1, $v0											
	
	li $v0, 16		
	move $a0, $s0								
	syscall
		
	la $a0, buffer											
	move $a1, $s1								
		
	li $t0, 1												
	move $t1, $a0											
	move $t2, $a0											
	j reverse_file

write_to_file:
	li $v0, 13				
	la $a0, outputFileName							
	li $a1, 1				
	li $a2, 0						
	syscall
	move $s0, $v0										
		
	li $v0, 15				
	move $a0, $s0										
	la $a1, buffer									
	move $a2, $s1										
	syscall
			
	li $v0, 16										
	move $a0, $s0										
	syscall
			
exit:
	li $v0, 10										
	syscall
			
reverse_file:
	find_delimiter:
		bge $t0, $s1, write_to_file
		lb $t3, 0($t2)									
		beq $t3, 13, reverse_line						
		addi $t2, $t2, 1								
		addi $t0, $t0, 1								
		j find_delimiter
			
	reverse_line:
		addi $t3, $t2, -1
				
		reverse_line_loop:
			lb $t8, 0($t1)								
			lb $t9, 0($t3)							
			
			sb $t9, 0($t1)								
			sb $t8, 0($t3)								
				
			addi $t1, $t1, 1						
			addi $t3, $t3, -1							
				
			bge $t1, $t3, reverse_line_end_loop
			j reverse_line_loop
				
		reverse_line_end_loop:
			addi $t2, $t2, 2
			move $t1, $t2							
			j find_delimiter
