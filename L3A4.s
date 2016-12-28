## Daniel Revie
## 3/8/2016
## Lab 3 A4

.data
str1: .asciiz "Please enter m: "
str2: .asciiz "Please enter n: "
str3: .asciiz "Please enter p: "
str4: .asciiz "Root: "
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

## Read m
li $v0, 6
syscall 
mov.s $f1, $f0

## Print str2
li $v0, 4
la $a0, str2
syscall 

## Read n
li $v0, 6
syscall 
mov.s $f2, $f0

## Print str3
li $v0, 4
la $a0, str3
syscall 

## Read p
li $v0, 6
syscall 
mov.s $f3, $f0

## find root 
## [-b + sqrt((b^2) - 4(a)(c))] / 2a

neg.s $f10, $f2               # -b
mul.s $f11, $f2, $f2          # b^2 
li.s $f20, 4.0                # 4 operator 
li.s $f21, 2.0
mul.s $f12, $f1, $f3          # ac
mul.s $f12, $f12, $f20
sub.s $f0, $f11, $f12 

jal sqrt 

## completed answer 
add.s $f0, $f0, $f10
mul.s $f15, $f1, $f21 
div.s $f0, $f0, $f15
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


End:
	## Print Result
	li $v0, 4
	la $a0, str4
	syscall 
	
	## Print int
	li $v0, 2
	mov.s $f12, $f0 
	syscall 
	
	## End program 
	li $v0, 10 
	syscall 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	