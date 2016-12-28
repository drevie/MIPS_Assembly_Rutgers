.data 0x10000800
OrinRow_0:
.word 1, 2, 3, 4, 5, 6
OrinRow_1:
 .word 7, 8, 9, 10, 11, 12
OrinRow_2:
.word 13, 14, 15, 16, 17, 18
OrinRow_3:
.word 19, 20, 21, 22, 23, 24
OrinRow_4:
.word 25, 26, 27, 28, 29, 30
OrinRow_5:
.word 31, 32, 33, 34, 35, 36
.data 0x10000900
TransRow_0:
.word 0, 0, 0, 0, 0, 0
TransRow_1:
.word 0, 0, 0, 0, 0, 0
TransRow_2:
.word 0, 0, 0, 0, 0, 0
TransRow_3:
.word 0, 0, 0, 0, 0, 0
TransRow_4:
.word 0, 0, 0, 0, 0, 0
TransRow_5:
.word 0, 0, 0, 0, 0, 0
 .text 0x00400000
main:
#Your code starts from here


la $s0, OrinRow_0 
la $s1, OrinRow_1 
la $s2, OrinRow_2 
la $s3, OrinRow_3 
la $s4, OrinRow_4 
la $s5, OrinRow_5 

la $t0, TransRow_0 
la $t1, TransRow_1 
la $t2, TransRow_2 
la $t3, TransRow_3 
la $t4, TransRow_4 
la $t5, TransRow_5

li $t6, 0 
li $s6, 0 
li $s7, 6 

Loop: 
	
	
	## Increment original addresses 
	add $s0, $s0, $t6 
	add $s1, $s1, $t6
	add $s2, $s2, $t6 
	add $s3, $s3, $t6 
	add $s4, $s4, $t6
	add $s5, $s5, $t6 
	
	## Increment transpose addresses 
	add $t0, $t0, $t6 
	add $t1, $t1, $t6
	add $t2, $t2, $t6 
	add $t3, $t3, $t6 
	add $t4, $t4, $t6
	add $t5, $t5, $t6 
	
	
	## Load and save to Transpose 
	lw $t7, ($s0)
	sw $t7, ($t0)
	
	lw $t7, ($s1)
	sw $t7, ($t1)
	
	lw $t7, ($s2)
	sw $t7, ($t2)
	
	lw $t7, ($s3)
	sw $t7, ($t3)
	
	lw $t7, ($s4)
	sw $t7, ($t4)
	
	lw $t7, ($s5)
	sw $t7, ($t5)
	
	## Increment address iterator 
	addi $t6, $t6, 4 
	
	## Increment iteraetor 
	addi $s6, $s6, 1 
	
	beq $s6, $s7, End  
	
	j Loop 
	
	
End:
	li $v0, 10 
	syscall 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		