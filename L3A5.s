## Daniel Revie
## Lab 3 A5

.data
str1: .asciiz "Please enter your floating point radius: "
str2: .asciiz "Please enter your floating point height: "
str3: .asciiz "Surface Area Result: "
endl: .asciiz "\n"
str4: .asciiz "Volume Result: "
def:     .float 2.0              # define immediate real operands
def2:    .float -1.0
def3:    .float 0.0


.text 

main:

## Print str1
li $v0, 4
la $a0, str1 
syscall 

## Read Radius
li $v0, 6
syscall 
mov.s $f1, $f0

## Print str2
li $v0, 4
la $a0, str2 
syscall 

## Read Height
li $v0, 6
syscall 
mov.s $f2, $f0




calculateSurfaceArea:
sub.s $f10, $f10, $f10 
## save r 
add.s $f7, $f1, $f10

##  save r for volume 
add.s $f21, $f1, $f10 
## save h for volume 
add.s $f22, $f2, $f10 

## (r^2 + h^2)
mul.s $f1, $f1, $f1          # r^2
mul.s $f2, $f2, $f2          # h^2 
add.s $f0, $f1, $f2          # r^2 + h^2 


jal sqrt 

## pi 
li.s $f6, 3.1415

## pi*r^2 
mul.s $f1, $f1, $f6 

## pi*r
mul.s $f7, $f6, $f7 

## pi*r*sqrt(r^2 + h^2)
mul.s $f0, $f0, $f7 

## [pi*r^2 + pi*r*sqrt(r^2 + h^2)]
add.s $f0, $f1, $f0 


j PrintSurface


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
		 
		 

		 
volume:
	li.s $f23, 3.0 
	## r^2 
	mul.s $f21, $f21, $f21
	## r^2 * h 
	mul.s $f21, $f21, $f22 
	## pi*r^2*h
	mul.s $f21, $f21, $f6 
	#3 [pi*r^2*h] / 3
	div.s $f21, $f21, $f23 
	
	mov.s $f0, $f21 
	
	j End
		 
PrintSurface:
	## Print Results 
	li $v0, 4 
	la $a0, str3
	syscall 
	
	## Print $f0 
	li $v0, 2
	mov.s $f12, $f0 
	syscall 
	
	## print space
	li $v0, 4
	la $a0, endl
	syscall
	
	j volume
	
End:
	## Print Results
	li $v0, 4
	la $a0, str4 
	syscall 
	
	## Print $f0 
	li $v0, 2
	mov.s $f12, $f0
	syscall 
	
	## End Program
	li $v0, 10 
	syscall 
	