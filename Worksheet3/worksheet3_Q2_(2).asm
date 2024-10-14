.data
str: .asciiz "number of rows needed: "
pattern: .asciiz "*"
gap: .asciiz " "
new_line: .asciiz "\n"
	
.text

main:
	li $v0, 4
	la $a0, str
	syscall
	
	li $v0, 5
	syscall
	move $t0, $v0
	
	li $t1, 0
	j out_loop
	
out_loop:
	addi $t1, $t1, 1
	bgt $t1, $t0, exit_out_loop
	
	sub $t3, $t0, $t1
	j add_gap
	
add_gap:
	blez $t3, out_loop_count
	
	li $v0, 4
	la $a0, gap
	syscall
	
	subi $t3, $t3, 1
	j add_gap
	
out_loop_count:
	add $t4, $t1, $t1
	subi $t4, $t4, 1
	
	j in_loop
	
in_loop:
	blez $t4, in_loop_exit
	
	li $v0, 4
	la $a0, pattern
	syscall
	
	subi $t4, $t4, 1
	j in_loop
	
in_loop_exit:
	li $v0, 4
	la $a0, new_line
	syscall
	
	j out_loop
	
exit_out_loop:
	li $v0, 10
	syscall
