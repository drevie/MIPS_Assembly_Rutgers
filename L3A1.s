# Daniel Revie
# 2/24/2016 
# Lab 3 Assignmnet 1 

.data
str1: .asciiz "Enter A: "
str2: .asciiz "\nEnter B: " 
opt1: .asciiz "\n1) A and B, "
opt2: .asciiz "\n2) A or B, "
opt3: .asciiz "\n3) A xnor B, "
opt4: .asciiz "\n4) A xor B, "
opt5: .asciiz "\n5) A nand B,"
opt6: .asciiz "\n6) Exit."
str3: .asciiz "\nYour choice: "
Print1: .asciiz "1) A and B = "
Print2: .asciiz "2) A or B = "
Print3: .asciiz "3) A xnor B = "
Print4: .asciiz "4) A xor B = "
Print5: .asciiz "5) A nand B ="


.text 


main: 

	## Print str1 
	li $v0, 4
	la $a0, str1 
	syscall 
	## Read in first integer 
	li $v0, 5 
	syscall  
	move $t0, $v0                        # first integer in $t0 A
	
	## Print str2 
	li $v0, 4
	la $a0, str2 
	syscall 
	## Read in first integer 
	li $v0, 5 
	syscall 
	move $t1, $v0                         # second integer in $t1 B
	
	## Print opt1 
	li $v0, 4
	la $a0, opt1 
	syscall 
	## Print opt2 
	li $v0, 4
	la $a0, opt2
	syscall 
	## Print opt3 
	li $v0, 4
	la $a0, opt3
	syscall 
	## Print opt4 
	li $v0, 4
	la $a0, opt4
	syscall 
	## Print opt5 
	li $v0, 4
	la $a0, opt5 
	syscall 
	## Print opt6 
	li $v0, 4
	la $a0, opt6 
	syscall 
	
	
	START:
	
		## Print str3 
		li $v0, 4
		la $a0, str3 
		syscall 
		## Read Choice
		li $v0, 5
		syscall 
		move $s0, $v0 
	
		## Identify Case 
		li $t2, 1                           # initialize comparator 
		beq $s0, $t2, AND
		addi $t2, 1                         # iterate comparator 
		beq $s0, $t2, OR
		addi $t2, 1
		beq $s0, $t2, XNOR
		addi $t2, 1
		beq $s0, $t2, XOR
		addi $t2, 1
		beq $s0, $t2, NAND
		addi $t2, 1
		beq $s0, $t2, END
	
	
	AND:
		li $t2, 0                       # restore $t2 
		and $t2, $t0, $t1 
		
		##Finish
		li $v0, 4
		la $a0, Print1 
		syscall
		li $v0, 1
		move $a0, $t2 
		syscall 
		
		j START
	OR:
		li $t2, 0 
		and $t2, $t0, $t1     

		#Finish
		li $v0, 4
		la $a0, Print2 
		syscall
		li $v0, 1
		move $a0, $t2 
		syscall        
		
		j START
	XNOR:
		li $t2, 0 
		## XNOR -- NOR -- Sequence 
		nor $t2, $t0, $t1
		nor $t3, $t2, $t0 
		nor $t4, $t2, $t1 
		nor $t5, $t4, $t3 
		li $t2, 0 
		move $t2, $t5

		#Finish
		li $v0, 4
		la $a0, Print3 
		syscall
		li $v0, 1
		move $a0, $t2 
		syscall     
		
		j START 
	XOR: 
		li $t2, 0 
		## XOR -- NOR -- Sequence 
		nor $t2, $t0, $t0
		nor $t3, $t1, $t1 
		nor $t4, $t3, $t2 
		nor $t5, $t0, $t1 
		nor $t6, $t5, $t5 
		li $t2, 0 
		move $t2, $t6 
		
		#Finish
		li $v0, 4
		la $a0, Print4 
		syscall
		li $v0, 1
		move $a0, $t2 
		syscall 
		
		j START 
	NAND:
		li $t2, 0
		## NAND -- NOR -- Sequence 
		nor $t2, $t0, $t0
		nor $t3, $t1, $t1 
		nor $t4, $t3, $t2 
		nor $t5, $t4, $t4 
		li $t2, 0
		move $t2, $t5 
		
		#Finish
		li $v0, 4
		la $a0, Print5 
		syscall
		li $v0, 1
		move $a0, $t2 
		syscall 
		
		j START 
		 
	
	END:
	
	
	## End program
	li $v0, 10
	syscall 
	
	
	
	
	