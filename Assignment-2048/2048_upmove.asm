.data
    filename: .asciiz "gamestate.txt"
    buffer: .space 256
    array: .word 0:16    # 4x4 array (16 words)
    space: .asciiz " "
    newline: .asciiz "\n"
    prompt: .asciiz "\nEnter 'm' for move or 'q' to quit: "

.text
main:
    # Initialize the array to zeros
    la $s1, array
    li $t0, 16         # number of elements
init_loop:
    sw $zero, ($s1)
    addi $s1, $s1, 4
    addi $t0, $t0, -1
    bnez $t0, init_loop

    # Open file
    li $v0, 13
    la $a0, filename
    li $a1, 0        # read mode
    li $a2, 0
    syscall
    move $s0, $v0    # save file descriptor

    # Read file
    li $v0, 14
    move $a0, $s0
    la $a1, buffer
    li $a2, 256
    syscall

    # Close file
    li $v0, 16
    move $a0, $s0
    syscall

    # Initialize pointers for reading numbers
    la $s0, buffer   # source pointer
    la $s1, array    # destination pointer
    li $s2, 16       # counter for 16 numbers

read_loop:
    li $t0, 0        # current number

number_loop:
    lb $t1, ($s0)    # load character
    beq $t1, 32, store_num   # space
    beq $t1, 0, store_num    # null
    sub $t1, $t1, 48         # ASCII to int
    mul $t0, $t0, 10
    add $t0, $t0, $t1
    addi $s0, $s0, 1
    j number_loop

store_num:
    # Add range check to avoid unexpected values
    bltz $t0, reset_value
    bgt $t0, 32767, reset_value   # upper bound for valid integers
    j store_num_end

reset_value:
    li $t0, 0    # reset out-of-bound values to zero

store_num_end:
    sw $t0, ($s1)    # store number in array
    addi $s1, $s1, 4
    addi $s0, $s0, 1
    addi $s2, $s2, -1
    bnez $s2, read_loop

    # Initial array print
    jal print_array

game_loop:
    # Print prompt
    li $v0, 4
    la $a0, prompt
    syscall

    # Read character
    li $v0, 12
    syscall
    
    # Check if quit
    li $t0, 'q'
    beq $v0, $t0, exit
    
    # Check if move
    li $t0, 'm'
    bne $v0, $t0, game_loop
    
    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    # Process move for each row
    la $s0, array
    li $s1, 4        # 4 columns

process_columns:
    move $a0, $s0    # current row address
    jal shift_up
    jal combine
    jal shift_up   # shift again after combining
    
    addi $s0, $s0, 4    # next column
    addi $s1, $s1, -1
    bnez $s1, process_columns

    # Print updated array
    jal print_array
    j game_loop

# Function to print array
print_array:
    la $s0, array
    li $s1, 4        # rows

print_outer_loop:
    li $s3, 4        # reset column counter

print_inner_loop:
    # Print number
    li $v0, 1
    lw $a0, ($s0)
    syscall

    # Print space
    li $v0, 4
    la $a0, space
    syscall

    addi $s0, $s0, 4
    addi $s3, $s3, -1
    bnez $s3, print_inner_loop

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    subi $s1, $s1, 1
    bnez $s1, print_outer_loop
    
    jr $ra

# Function to shift non-zero numbers left
shift_up:
    move $t0, $a0    # row start
    li $t1, 0        # write position
    li $t2, 0        # read position
    
shift_loop:
    beq $t2, 4, pad_zeros    # if done reading
    sll $t3, $t2, 4          # multiply by 16
    add $t3, $t0, $t3        # get read address
    lw $t4, ($t3)            # load number
    
    beqz $t4, next_pos       # skip if zero
    sll $t5, $t1, 4          # multiply by 16
    add $t5, $t0, $t5        # get write address
    sw $t4, ($t5)            # store number
    addi $t1, $t1, 1         # increment write position
    
next_pos:
    addi $t2, $t2, 1         # increment read position
    j shift_loop

pad_zeros:
    beq $t1, 4, shift_done   # if done padding
    sll $t3, $t1, 4          # multiply by 16
    add $t3, $t0, $t3        # get address
    sw $zero, ($t3)          # store zero
    addi $t1, $t1, 1         # increment position
    j pad_zeros

shift_done:
    jr $ra

# Function to combine equal adjacent numbers
combine:
    move $t0, $a0    # row start
    li $t1, 0        # position
    
combine_loop:
    beq $t1, 3, combine_done  # if at last position
    sll $t2, $t1, 4           # multiply by 16
    add $t2, $t0, $t2         # get current address
    
    lw $t3, ($t2)             # load current number
    lw $t4, 16($t2)            # load next number
    
    beqz $t3, next_combine    # skip if zero
    bne $t3, $t4, next_combine # skip if not equal
    
    add $t3, $t3, $t4	         # combine numbers
    sw $t3, ($t2)             # store result
    sw $zero, 16($t2)          # clear next position
    
next_combine:
    addi $t1, $t1, 1          # increment position
    j combine_loop
    
combine_done:
    jr $ra

exit:
    li $v0, 10
    syscall
