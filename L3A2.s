# Daniel Revie
# 2/24/2016
# Lab 3 Assignment 2 

.data 
$a1: .space 12 	  ## Declare array of 100 bytes
copyArray: .space 12   ## Copy array 
str1: .asciiz "Please enter the number of elements in your array: "
str2: .asciiz "Please enter your integer: "
str3: .asciiz "Please enter an integer for insertion: "
str4: .asciiz ", "


.text 

main: 
	## Print str1
	li $v0, 4
	la $a0, str1
	syscall 
	
	## Read in number of elements 
	li $v0, 5
	syscall
	move $t0, $v0
	
	addi $s3, $t0, 1
	
	li $t1, 0        # initialize read loop iterator 
	li $t2, 0        # array iterator 
	
	ReadLoop:
		mul $t2, $t2, 4
		beq $t1, $t0, BeginSort
		
		## Print str2
		li $v0, 4
		la $a0, str2
		syscall
		
		## Read in integer
		li $v0, 5
		syscall 
		sw $v0, $a1($t2)
		
		addi $t2, 1  # increment iterator 
		addi $t1, 1  # increment array iterator 
		
		j ReadLoop
	
	BeginSort:
		## Restore iterators
		li $t1, 0
		li $t2, 0 
		

		la  $t0, $a1      # Copy the base address of your array into $t1
		add $t0, $s3, $zero   # 1000 bytes      
		mul $t0, $t0, 4
	outterLoop:             # Used to determine when we are done iterating over the Array
		add $t1, $0, $0     # $t1 holds a flag to determine when the list is sorted
		la  $a0, $a1      # Set $a0 to the base address of the Array
	innerLoop:                  # The inner loop will iterate over the Array checking if a swap is needed
		lw  $t2, 0($a0)         # sets $t0 to the current element in array
		lw  $t3, 4($a0)         # sets $t1 to the next element in array
		slt $t5, $t2, $t3       # $t5 = 1 if $t0 < $t1
		beq $t5, $0, continue   # if $t5 = 1, then swap them
		add $t1, $0, 1          # if we need to swap, we need to check the list again
		sw  $t2, 4($a0)         # store the greater numbers contents in the higher position in array (swap)
		sw  $t3, 0($a0)         # store the lesser numbers contents in the lower position in array (swap)
	continue:
		addi $a0, $a0, 4            # advance the array to start at the next location from last time
		bne  $a0, $t0, innerLoop    # If $a0 != the end of Array, jump back to innerLoop
		bne  $t1, $0, outterLoop    # $t1 = 1, another pass is needed, jump back to outterLoop
		
			
		## Print str3 
		li $v0, 4
		la $a0, str3
		syscall 
		
		## Read integer 
		li $v0, 5
		syscall 
		move $t4, $v0 
		
		li $s0, 0
		li $s1, 0
		li $t6, 0 
		BinarySearch:
			addi $s0, 1
			la $a0, $a1 
			add $t0, $t0, 1000 
			lw $t0, 0($a0)
			slt $t5, $t2, $t4
			beq $t5, $0, continue 
			CopyLoop:
				addi $s0, 1
				beq $t3, $s1, PrintArray
				beq $s0, $s1, insertValue
				la $a1, copyArray
				lw $t7, 0($a0)
				sw $t7, 0($a1)
				addi $a0, $a0, 4
				addi $a1, $a1, 4
				j CopyLoop
			
			insertValue:
				sw $t4, 0($a1)
				addi $a1, $a1, 4
				j CopyLoop
			
			PrintArray:
				beq $s3, $t6, End
				la $a1, copyArray
				lw $a0, 0($a1) 
				
				li $v0, 1
				syscall 
				li $v0, 4
				la $a0, str4
				syscall 
				
				addi $a0, $zero, 4
				j PrintArray
		
		End:
		
		li $v0, 10
		syscall 