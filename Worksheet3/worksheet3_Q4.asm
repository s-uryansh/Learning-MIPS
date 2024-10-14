.data
str: .asciiz "enter integer to convert: "
binary: .space 33  

.text
main:
# Print string and read integer
    la $a0, str
    li $v0, 4
    syscall
# Store input integer in $t0
    li $v0, 5
    syscall
    move $t0, $v0  

# Check if integer is negative
    blt $t0, $zero, negative
    j positive

negative:
# Calculate 2's complement
    li $t1, -1
    xor $t0, $t0, $t1
    addi $t0, $t0, 1
    li $t3, 1  # Set sign bit for negative numbers
    j convert

positive:
    li $t3, 0  # Clear sign bit for positive numbers

convert:
# Converting
    la $a0, binary
    li $t1, 31 
loop:
#if lsb 1 stores 1 else 0
    andi $t2, $t0, 1
    beq $t2, $zero, zero
    li $t2, '1'
    j store
zero:
    li $t2, '0'
store:
    sb $t2, 0($a0)
    addi $a0, $a0, 1
    srl $t0, $t0, 1
    addi $t1, $t1, -1
    bgt $t1, $zero, loop

# Set the sign bit
    beq $t3, $zero, end
    li $t2, '1'
    sb $t2, -1($a0)

end:
# Null-terminate binary string
    li $t2, 0
    sb $t2, 0($a0)

# Null-terminate binary string
    li $t2, 0
    sb $t2, 0($a0)

# Print binary string
    la $a0, binary
    li $v0, 4
    syscall

# Exit
    li $v0, 10
    syscall
