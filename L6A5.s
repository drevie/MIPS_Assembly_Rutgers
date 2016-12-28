## Daniel Revie
## Computer Architecre 
## 4/24/2016
## Lab 6 A 5

.data 

str3: .asciiz "Please enter the value to be used: "
str1: .asciiz "The value of sinh^-1: "
str2: .asciiz "\nThe value of cosh^-1: "




.text 


main:
	
	## Print str3
	li $v0, 4
	la $a0, str3
	syscall 
	
	## Read float  
	li $v0, 5
	syscall  
	move $s0, $v0              ## N stored in $s0 
	
	li $t0, -1                  # Summation iterator 
	
	
	

## Begin summation 
li.s $f22, 1.0            # value 1 
li.s $f23, 2.0            # value 2 
li.s $f24, 4.0            # value 4 
li.s $f29, 1.57079632679  # value pi/2  
li.s $f10, 0.0            # N count 



# terms 
li.s $f19, -1.0         #(-1)^n 
li.s $f18, 1.0          #(2n)!
li.s $f17, 1.0          # 4^n 
li.s $f16, 1.0          # (n!) ^ 2 
li.s $f15, 1.0          # (2n + 1)
li.s $f14, 1.0          # (pi/2)^(2n +1 )
li.s $f25, 0.0          # Sigma: [(-1)^n * (2n)!] / 4^n * (n!)^2 * (2n+1)

li.s $f30, 0.0          # sinh^-1
li.s $f31, 0.0          # cosh^-1



Summation:
	addi $t0, $t0, 1           # Increment N iterations 
	add.s $f10, $f10, $f22     # increment n count 
	# terms 
	li.s $f19, -1.0         #(-1)^n 
	li.s $f18, 1.0          #(2n)!
	li.s $f17, 1.0          # 4^n 
	li.s $f16, 1.0          # (n!) ^ 2 
	li.s $f15, 1.0          # (2n + 1)
	li.s $f14, 1.0          # (pi/2)^(2n +1 )
	li.s $f25, 0.0          # Sigma: [(-1)^n * (2n)!] / 4^n * (n!)^2 * (2n+1)
	li.s $f7, 0.0           # reset cosh 
	
	beq $t0, $s0, End 
	

CalculationLoop:
		
	##(-1)^n
	li.s $f26, 0.0 			 # reset register 
	li.s $f27, 0.0  		 # reset register
	add.s $f26, $f26, $f10   # N = number of times to raise to exponent 
	j Exponential_A
	ReturnExponential_A:
	
	
	## 4^n 
	li.s $f26, 0.0            # reset register 
	li.s $f27, 0.0            # reset register 
	add.s $f26, $f26, $f10    # perform exponential 10 times
	j Exponential_B
	ReturnExponential_B:
	
	
	
	## (pi/2)^(2n+1)
	li.s $f26, 0.0 
	li.s $f27, 0.0 
	mul.s $f26, $f10, $f23    # 2n 
	add.s $f26, $f26, $f22    # 2n+1 
	j Exponential_C
	ReturnExponential_C:
	
	
	
	## (2n)! 
	li.s $f26, 0.0            # reset register 
	li.s $f27, 0.0            # reset register 
	mul.s $f26, $f10, $f23    # 2n 
	j Factorial_I
	ReturnFactorial_I:
	
	
	
	## (n!)^2 
	li.s $f26, 0.0 
	li.s $f27, 0.0 
	add.s $f26, $f26, $f10 
	j Factorial_II  		   # n! 
	ReturnFactorial_II:
	mul.s $f16, $f16, $f23     # 2n! 
	
	## (2n+1)
	mul.s $f15, $f15, $f10     # 2n 
	add.s $f15, $f15, $f22     # 2n + 1 
	

	
	## Complete cosh 
	div.s $f7, $f14, $f15 
	add.s $f12, $f12, $f7 
	
	## Complete sinh
	mul.s $f19, $f19, $f18     # [(-1)^n * (2n)!]
	mul.s $f17, $f17, $f16     # 4^n * (n!)^2
	mul.s $f17, $f17, $f15     # 4^n * (n!)^2 * (2n+1)
	div.s $f19, $f19, $f17     # Sigma: [(-1)^n * (2n)!] / 4^n * (n!)^2 * (2n+1)]
	mul.s $f19, $f19, $f14     # [(-1)^n * (2n)!] / 4^n * (n!)^2 * (2n+1)] * (pi/z)^(2n + 1)
	add.s $f11, $f11, $f19     # add result to sum 
	
	

	
	
	j Summation



Exponential_A:
	add.s $f27, $f27, $f22   # increment exponential counter 
	c.eq.s $f26, $f27        # test if exponential is equal to count 
	bc1t ReturnExponential_A # branch return to finish calculation 
	mul.s $f19, $f19, $f19   # perform square 
	j Exponential_A          # repeat otherwise 	

	
Exponential_B:
	add.s $f27, $f27, $f22   # increment exponential counter 
	c.eq.s $f26, $f10        # test if exponential is equal to count 
	bc1t ReturnExponential_B # branch return to finish calculation 
	mul.s $f17, $f17, $f24   # perform square 
	j Exponential_B          # repeat otherwise 	

	
Exponential_C:
	add.s $f27, $f27, $f22   # increment exponential counter 
	c.eq.s $f26, $f27        # test if exponential is equal to count 
	bc1t ReturnExponential_C # branch return to finish calculation 
	mul.s $f14, $f14, $f29   # perform square 
	j Exponential_C          # repeat otherwise 
	
Factorial_I: 
	add.s $f27, $f27, $f22    # increment factorial counter
	c.eq.s $f26, $f27         # test if factorial is equal to count 
	bc1t ReturnFactorial_I    # branch return to finish calculation 	
	mul.s $f18, $f18, $f27    # multiple factorial element 
	j Factorial_I             # repeat otherwise 
	
Factorial_II: 
	add.s $f27, $f27, $f22     # increment factorial counter
	c.eq.s $f26, $f27          # test if factorial is equal to count 
	bc1t ReturnFactorial_II    # branch return to finish calculation 	
	mul.s $f16, $f16, $f27     # multiple factorial element 
	j Factorial_II             # repeat otherwise 
	

	

	


	
	
End:

	# print output str1 
	li $v0, 4
	la $a0, str1  
	syscall 
	
	## Print sinh^-1
	li $v0, 2 
	mov.s $f12, $f11 
	syscall 
	
	## Print str2 
	li $v0, 4 
	la $a0, str2 
	syscall 
	
	## Print cosh^-1 
	li $v0, 2 
	mov.s $f12, $f12
	syscall 
	
	## End Program 
	li $v0, 10
	syscall 
	
	

	
	