.data

string: .ascii "Hello World\n"

.text

	li $v0 ,4
	la $a0 , string #printing string
	syscall
