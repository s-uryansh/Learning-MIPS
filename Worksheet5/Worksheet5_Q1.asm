.data
    input_file_name: .asciiz "input.txt"
    output_file_name: .asciiz "output_Q1.txt"
    read_buffer: .space 1024
    write_buffer: .space 20
    error_message: .asciiz "An error occurred.\n"
    count_message: .asciiz "Character count: "

.text
.globl main

main:
    # Open input file for reading
    li $v0, 13
    la $a0, input_file_name
    li $a1, 0  # Read mode
    li $a2, 0
    syscall
    bltz $v0, handle_error
    move $s0, $v0  # Save file descriptor

    # Initialize character count
    li $s1, 0

    # Read from file and count characters
read_file_loop:
    li $v0, 14
    move $a0, $s0
    la $a1, read_buffer
    li $a2, 1024
    syscall
    bltz $v0, handle_error
    beqz $v0, end_read_file_loop
    add $s1, $s1, $v0
    j read_file_loop
end_read_file_loop:

    # Close input file
    li $v0, 16
    move $a0, $s0
    syscall

    # Print character count to console
    li $v0, 4
    la $a0, count_message
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 11
    li $a0, 10  # Newline
    syscall

    # Convert integer to string for file output
    la $a0, write_buffer
    move $a1, $s1
    jal integer_to_string
    move $s2, $v0  # Save the length of the string

    # Open output file for writing
    li $v0, 13
    la $a0, output_file_name
    li $a1, 1  # Write mode
    li $a2, 0
    syscall
    bltz $v0, handle_error
    move $s0, $v0  # Save file descriptor

    # Write character count to output file
    li $v0, 15
    move $a0, $s0
    la $a1, write_buffer
    move $a2, $s2  # Use the length returned by integer_to_string
    syscall
    bltz $v0, handle_error

    # Close output file
    li $v0, 16
    move $a0, $s0
    syscall

    # Exit program
    li $v0, 10
    syscall

handle_error:
    # Print error message
    li $v0, 4
    la $a0, error_message
    syscall
    # Exit with error code
    li $v0, 10
    li $a0, 1
    syscall

integer_to_string:
    li $t0, 10  # Divisor for base 10
    move $t1, $a0  # Start of buffer
    move $t2, $a1  # Copy of integer
    li $t4, 0      # Length of string

    # Special case for zero
    bnez $t2, convert_digits
    li $t3, 48  # ASCII '0'
    sb $t3, ($t1)
    li $v0, 1
    jr $ra

convert_digits:
    div $t2, $t0
    mfhi $t3  # Remainder
    mflo $t2  # Quotient
    addi $t3, $t3, 48  # Convert to ASCII
    sb $t3, ($t1)
    addi $t1, $t1, 1
    addi $t4, $t4, 1
    bnez $t2, convert_digits

    # Reverse the string
    move $t1, $a0  # Start of buffer
    add $t2, $t1, $t4
    subi $t2, $t2, 1  # End of buffer
reverse_string_loop:
    bge $t1, $t2, end_reverse_string
    lb $t5, ($t1)
    lb $t6, ($t2)
    sb $t6, ($t1)
    sb $t5, ($t2)
    addi $t1, $t1, 1
    subi $t2, $t2, 1
    j reverse_string_loop
end_reverse_string:

    # Return string length
    move $v0, $t4
    jr $ra
