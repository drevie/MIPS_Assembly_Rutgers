## Daniel Revie
## 4/20/16
## Lab 5 

.data 0x10000480
str1: .asciiz "This is lab 5, A2: \n"
str2: .asciiz "C = "
str3: .asciiz ", "


ArrayA: .word 1, 2, 3


ArrayB: .word 8, 7, 6



.text 0x00400000
.globl main

main:

## Print str1
li $v0, 4 
la $a0, str1
syscall

## Print str2
li $v0, 4
la $a0, str2 
syscall

la $s0, ArrayB         # Load address of B into $s0
la $s1, ArrayA         # Load address of A into $s1 
#la $s2, ArrayC         # Load address of C into $s1

li $t0, 0         # initialize iterator 

li $s3, 3         # 3 count 



Kproduct:
	li $t5, 1                   # Load value of A
	li $t1, 0                   # initialize second iterator 
	beq $t0, $s3, End 
	lw $t2, ($s0)
	addi $t0, $t0, 1            # Increment overall iterator 
	addi $s0, $s0, 4 
	

	j Kloop




Kloop:
		beq $t1, $s3, Kproduct  # When 3 calculations are made 
		mul $t4, $t2, $t5       # A*B
		addi $t5, $t5, 1        # increment A
		addi $t1, $t1, 1        # increment iterator 
		
		## Print next value 
		li $v0, 1
		move $a0, $t4 
		syscall               
		
		## Print space 
		li $v0, 4
		la $a0, str3 
		syscall 
		
		j Kloop 
End: 
	## End 
	li $v0, 10 
	syscall

