## Daniel Revie
## 4/20/2016 
## Lab 5 A3

.data  0x10000860

Vector_X: .word 1, 2, 3, 4, 5, 6, 7
		  .data 0x10000880
		  
Vector_Y: .word 4, 5, 6, 7, 8, 9, 10
		  .data 0x10000C80
		  
Matrix_T: .word 0, -4, -7, 2, -6, 5, 3
		  .data 0x10001080
		  .word 4, 0, -5, -1, 3, -7, 6
		  .data 0x10001480
		  .word 7, 5, 0, -6, -2, 4, -1
		  .data 0x10001880
		  .word -2, 1, 6, 0, -7, -3, 5
		  .data 0x10001c80
		  .word 6, -3, 2, 7, 0, -1, -4
		  .data 0x10002080
		  .word -5, 7, -4, 3, 1, 0, -2
		  .data 0x10002480
	   	  .word -3, -6, 1, -5, 4, 2, 0 
		  .data 0x10002880
		  
Vector_Z: .word 0, 0, 0, 0, 0, 0, 0, 0





.text 0x00400000
.globl main

main:
## Assign vector addresses 
 la $t0, Vector_X                      # address of X in $t0 
 la $t1, Vector_Y                      # address of Y in $t1 
 la $t2, Vector_Z                      # address of Z in $t2
 #la $t2, Vector_Z                      # address of Z in $t2
## Multiply registers
mult $t0, $t1    
mflo $t2 

## END 
li $v0, 10 
syscall 
	
