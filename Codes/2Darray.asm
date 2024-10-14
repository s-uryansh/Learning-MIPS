
.data

arr: .word 2,5,1
     .word 3,7,1
     .word 3,10,1
     
size: .word 3
.eqv DATA_SIZE 4 #for int 4 , double 8

.text
#row major implementation
main:
	la $a0 , arr #reg a0 have address of my 2d array
	lw $a1 , size #reg a1 have size of my 2d array
	jal sum_diagonal #taking 2 parameter a0 and a1 adddr and size
	
	move $a0 ,$v0
	
	li $v0 , 1
	syscall
	
	#end
	li $v0 , 10
	syscall
sum_diagonal:
	li $v0 ,0 #sum
	li $t0 ,0 #index
	sum_loop:#implementing formula for row_major 2d Array
		mul $t1 , $t0 , $a1	 # t1 = rowIndex * colSize
		add $t1 , $t1 , $t0	 # (rowIndex * colSize)+ colIndex
		mul $t1 , $t1 , DATA_SIZE	 #((rowIndex * colSize) + colIndex) * data_size
		add $t1 ,$t1 , $a0	 #(((rowIndex * colSize) + colIndex) * data_size) + baseAddr
				 #t1 have value for index t0
		lw $t2 , ($t1)
		add $v0 , $v0 ,$t2	 #sum = sum + arr[i][i]
		addi $t0 , $t0 , 1	 #i++
		
		blt $t0 , $a1 , sum_loop	 # if(i < size) {
				 #	   loop
				 #	 }
	jr $ra