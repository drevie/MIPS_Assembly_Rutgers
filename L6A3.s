## Daniel Revie
## Computer Architecre 
## 4/24/2016
## Lab 6 A 3 



.data 
str1: .asciiz "Hello this is Lab 6 Assignment 3 \n"
str2: .asciiz "Please enter a value n: "
str3: .asciiz "Summation: (1/!k) = "




.text

main: 


## Print string 1 
li $v0, 4
la $a0, str1 
syscall 

## Print string 2
li $v0, 4
la $a0, str2 
syscall 

## Read N 
li $v0, 5
syscall
move $t0, $v0 


add $s0, $t0, $zero       # save N in s0 

## Begin summation 
li $t1, -1                 # N iterator 

li.s $f10, 0.0             # K count 
li.s $f22, 1.0 
li.s $f20, 1.0 			  # 1/ 
li.s $f25, 0.0            # Sigma: 1/k 

summation:
	addi $t1, 1               # increment N counter 
	add.s $f10, $f10, $f22    # increment K count 
	li.s $f11, 1.0            # k 
	li.s $f1, 0.0             # factorial iterator 
	beq $t0, $t1, End    
	
	j loop 

loop:  
	add.s $f1, $f1, $f22   # Increment factorial counter 
	mul.s $f11, $f1, $f11  # Add factorial element 
	c.eq.s $f1, $f10       # test if factorial is equal to count 
	bc1t divLoop           # branch to divide by factorial 
	j loop
	
	
divLoop:
	div.s $f15, $f20, $f11  # divide 1/!n 
	add.s $f25, $f25, $f15  # add sequence 
	j summation
	
End:
	## Print str3
	li $v0, 4 
	la $a0, str3
	syscall 
	
	## Print fp 
	li $v0, 2 
	mov.s $f12, $f25 
	syscall 
	
	## end program 
	li $v0, 10
	syscall
	
	

 




	