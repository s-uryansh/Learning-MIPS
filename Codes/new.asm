.data
N:           	  .word 5                 
fibonacci:       .space 20                  # array for Fibonacci numbers 10*4=40

newline:         .asciiz "\n"                

.text
.globl main

main:
  
    li $t0, 0                              #first  number
    li $t1, 1                               # second  number
    la $t2, fibonacci                       #  points to start of Fibonacci array
    sw $t0, 0($t2)                          # store first Fibonacci number in the array
    addi $t2, $t2, 4                        
    sw $t1, 0($t2)                          # store second Fibonacci number in the array
    addi $t2, $t2, 4                        #  next location

    li $t3, 2                               # current count  for how many numbers are generated
    la $t4, fibonacci                       #  points to the start of Fibonacci array

fibonacci_loop:
    lw $t5, -8($t2)                         # Load (n-2)th Fibonacci number
    lw $t6, -4($t2)                         # Load (n-1)th Fibonacci number
    add $t7, $t5, $t6                       # $t7 = (n-2)th + (n-1)th
    sw $t7, 0($t2)                          # Store the new Fibonacci number in the array

    addi $t2, $t2, 4                        #  next position in the array
    addi $t3, $t3, 1                        
    li $t8, 5                             
    blt $t3, $t8, fibonacci_loop          

   
    la $t2, fibonacci                       # reset $t2 to the start of Fibonacci array
    li $t9, 0                               #  start index for printing subsequences

print_subsequences:
    move $t4, $t2                           # point to  current index
    li $t5, 5                            
    sub $t5, $t5, $t9                       # Adjust the count to print from index $t9

print_loop:
    lw $a0, 0($t4)                          #  current Fibonacci number
    li $v0, 1                            
    syscall

    addi $t4, $t4, 4                       
    addi $t5, $t5, -1                       #  number of terms left to print
    bgtz $t5, print_loop                    # If more numbers remain, continue printing

   
    li $v0, 4                              
    la $a0, newline
    syscall

    addi $t2, $t2, 4                        # move start index to next Fibonacci number
    addi $t9, $t9, 1                        
    li $t5, 5                            
    bgt $t5, $t9, print_subsequences        #less than N

 
    li $v0, 10                             
    syscall