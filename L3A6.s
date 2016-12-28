## Daniel Revie
## Lab 3 Assignment 6 
.align 2
.data 
floatArray: .space 1000
str1: .asciiz "Please enter the size of your array: "
str2: .asciiz "Please input a floating point number: "
str3: .asciiz "The average is: "
str4: .asciiz "The standard deviation is: "
endl: .asciiz "\n"
# define immediate real operands
def:     .float 2.0              
def2:    .float -1.0
def3:    .float 0.0

.text 
main: 

## Print str1 
li $v0, 4
la $a0, str1 
syscall 

## Read int 1 
li $v0, 5
syscall 
move $t0, $v0 

## save the array size 
add $s1, $t0, $zero

li $t1, 0			# create iterator 
li $t3, 4			# create *4 

###############################################
readLoop: 

mul $t2, $t1, $t3   # byte addressing  

## Load string 1 
li $v0, 4 
la $a0, str2 
syscall 

## Read floating point number 
li $v0, 6 
syscall 
s.s $f0, floatArray($t2)
## Print the average float 
addi $t1, 1			# increment iterator 
beq $t0, $t1, Average

j readLoop
#################################################

Average:
	#addi $s2, $t0, 1
	li $t1, 0 
	li $t2, 0 
	li.s $f13, 0.0
	calculate: 
		
		mul $t2, $t3, $t1           # byte addressing 
		beq $t1, $t0, averageCalc   # if the array is empty calculate the average 
		lwc1 $f19, floatArray($t2)   # load floating point number from array 
		add.s $f13, $f19, $f13      # add the floating point number to the sum for the average 
		addi $t1, 1					# iterate counter 
		
		j calculate                 # otherwise continue looping 
	averageCalc:
	
		mtc1 $t0, $f20              # converting integer to single precision float 
		cvt.s.w $f20, $f20          # place conversion in $20 
		div.s $f13, $f13, $f20      # divide the average by the newly converted user input 
		 
		 
		## Print str3
		li $v0, 4
		la $a0, str3 
		syscall
		## Print the average float 
		li $v0, 2           
		mov.s $f12, $f13
		syscall 
		
		## Endl 
		li $v0, 4 
		la $a0, endl 
		syscall 
		
		j StandardDev
		
		End:
		
			
			
			
			## Print str4 
			li $v0, 4
			la $a0, str4
			syscall 
			
			## Print standard dev 
			li $v0, 2
			mov.s $f12, $f0
			syscall 
		
			
		## End program
		li $v0, 10
		syscall 
		
	StandardDev:
		li $t1, 0
		li $t2, 0 
		li.s $f15, 0.0
		StandardDevLoop:
			mul $t2, $t3, $t1              # byte addressing 
			beq $t1, $t0, interim              # if the array is empty calculate the average 
			lwc1 $f19, floatArray($t2)     # load floating point number from array 
			sub.s $f19, $f19, $f13         # (x - average)
			mul.s $f19, $f19, $f19         # (x - aveage)^2
			add.s $f15, $f15, $f19         # sum[x - average)^2]
			li.s $f19, 0.0                 # Restore f19 to 0 
			addi $t1, 1					   # iterate counter 
			j StandardDevLoop
		
		
		
	interim:
		mtc1 $t0, $f20              	   # converting integer to single precision float 
		cvt.s.w $f20, $f20                 # place conversion in $20 
		div.s $f15, $f15, $f20             # divide the average by the newly converted user input 
		mov.s $f0, $f15                    # move sum to $f0 to take sqrt 
		jal sqrt 
		j End  
		
	sqrt:
         # store $f1, $f2, $f3, $f4
         addi $sp, $sp, -16
         swc1 $f1, 12($sp)
         swc1 $f2, 8($sp)
         swc1 $f3, 4($sp)
         swc1 $f4, 0($sp)
         # program starts here
         lwc1 $f1, def($0)       # f1 = 2
         lwc1 $f5, def3($0)      # f5 = 0
         add.s $f3, $f5, $f1     # f1 = f3 = 2
         c.eq.s $f0, $f5         # if f0 != 0 start sqrt loop (sqrtr)
         bc1f sqrtr              # else :
         jr $ra                  # return 0 --> F12 is already 0

sqrtr:                           # recursive part
         div.s $f2, $f0, $f1     # f1 = ((f0 / f1)+f1)/2
         add.s $f1, $f1, $f2
         div.s $f1, $f1, $f3
         c.eq.s $f1, $f4         # if (f1 = f4)--> same f1 twice jump endsqrt
         bc1t esqrt
         add.s $f4, $f5, $f1     # else f4 = f1
         j sqrtr
         
esqrt:   add.s $f0, $f5, $f1     # set f0 = f1 as stated in contract
         # restore $f1, $f2, $f3, $f4
         lwc1 $f1, 12($sp)
         lwc1 $f2, 8($sp)
         lwc1 $f3, 4($sp)
         lwc1 $f4, 0($sp)
         addi $sp, $sp, 16
         
         jr $ra                   # return f0	
		
		
		
		
		
		
		
		
		
		