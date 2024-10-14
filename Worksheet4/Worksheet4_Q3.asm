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
