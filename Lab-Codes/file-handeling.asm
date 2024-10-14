.data

file_name: .asciiz "example1.txt"
buffer: .asciiz "Hello word! This is my first MIPS file handling program"
	
.text
#reading file
	li $v0 ,13 
	la $a0 , file_name
	la $a1 ,1
	la $a2 ,0
	syscall
	move $s0 , $v0
#writing file	
	li $v0 ,15
	move $a0 , $s0
	la $a1 , buffer
	la $a2 , 55
	syscall
#closing file	
	li $v0 ,16
	move $a0 , $s0
	syscall
	
	li $v0 , 10
	syscall