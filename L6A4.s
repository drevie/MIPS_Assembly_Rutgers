## Daniel Revie
## Computer Architecre 
## 4/24/2016
## Lab 6 A 4

.data 0x10000880
Matrix_A: 
	.word 2 4 6 8 10
	.data 0x10000C80
	.word 12 14 16 18 20
	.data 0x10001080
	.word 22 24 26 28 30
	.data 0x10001480
	.word 32 34 36 38 40
	.data 0x10001880
	.word 42 44 46 48 50
	
.data 0x10001000
	TransRow_0: .word 0 0 0 0 0
	TransRow_1: .word 0 0 0 0 0
	TransRow_2: .word 0 0 0 0 0
	TransRow_3: .word 0 0 0 0 0
	TransRow_4: .word 0 0 0 0 0
#rows are separated by 1024 bits for matrix_A

.text 0x00400000
.globl main 		
	
main:

la $t8,Matrix_A
la $t9,TransRow_0

li $t0, 5 # 5 Iterations for 5 rows 
li $t3, 0 # Transpose Iterator 
li $t7, 0 # Matrix_A Iterator 
li $s0, 0 # $s0  = 0


Loop:
	add $t8, $t8, $t7 #[$t8+0] adjusting address 
	add $t9, $t9, $t3
	lw $t5, 0($t8)
	sw $t5, 0($t9)

Loop1:
	addi $t3, $t3, 4 	#incremnt tranpose iterator by 4 (byte addressing)
	addi $t8, $t8, 1024
	add $t9, $t9, $t3
	lw $t5, 0($t8)
	sw $t5, 0($t9)

Loop2:
	addi $t3, $t3, 4
	addi $t8, $t8, 1024
	add $t9, $t9, $t3
	lw $t5, 0($t8)
	sw $t5, 0($t9)

Loop3:
	addi $t3, $t3, 4
	addi $t8, $t8, 1024
	add $t9, $t9, $t3
	lw $t5, 0($t8)
	sw $t5, 0($t9)

Loop4:
	addi $t3, $t3, 4
	addi $t8, $t8, 1024
	add $t9, $t9, $t3
	lw $t5, 0($t8)
	sw $t5, 0($t9)

## Adjust addres offset
addi $t8, $t8, -4096
addi $t8, $t8, 4
addi $t0, $t0,-1
bne $t0, $0, Loop
beq $t0, $0, END


END:
	li $v0, 10
	syscall

	
	
	
	
	
	
	
	
	
	