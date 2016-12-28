## Daniel Revie
## Assignment 3

.data 
str1: .asciiz "Please enter the first integer between 10 and 500 \n"
str2: .asciiz "Please enter the second integer between 10 and 500 \n"  
str3: .asciiz "The number enterered is out of bounds! \n" 
str4: .asciiz "The numbers are divisible by each other! \n" 
str5: .asciiz "The sum between the numbers has been calculated! \n" 
str6: .asciiz "The sum is: "


.text 

main:

## Printing sequence for str1
li $v0, 4
la $a0, str1
syscall

## Read in sequece for the first integer 
li $v0, 5
syscall
move $t0, $v0                     # First integer is placed in $t0

## Printing sequence for str2
li $v0, 4
la $a0, str2
syscall

## Read in sequece for the second integer 
li $v0, 5
syscall
move $t1, $v0                     # Second integer is placed in $t1


## Create boundrary registers
li $s0, 10
li $s1, 500

## Check lower bounds
blt $t0, $s0, OUTofBOUNDS
blt $t1, $s0, OUTofBOUNDS

## Check upper bound
bgt $t0, $s1, OUTofBOUNDS
bgt $t1, $s1, OUTofBOUNDS

## Test division 1
div $t0, $t1
mfhi $t6
beqz $t6, DIVISIBLE              

## Test division 2
div $t1, $t0
mfhi $t6
beqz $t6, DIVISIBLE            

## All Tests Have Been Passed
## Begin Addition

loop:

blt $t0, $t1, FirstSmaller
blt $t1, $t0, SecondSmaller

FirstSmaller:

addi $t0, 1                   # increment the first number

beq $t0, $t1, END             # jump to end when all numbers between are added

add $t5, $t0, $t5             # add the sum to current number

j FirstSmaller                # repeat loop

SecondSmaller:                # same process as the first but starting from the second number

addi $t1, 1

beq $t0, $t1, END

add $t5, $t1, $t5

j SecondSmaller

OUTofBOUNDS:

## Prepare to Print Error Message
li $v0, 4
la $a0, str3
syscall

j Close

DIVISIBLE:

## Prepare to Print Error Message
li $v0, 4
la $a0, str4
syscall

j Close

END:

## Prepare to Print Success Message
li $v0, 4
la $a0, str5
syscall

## Prepare to Print Sum
li $v0, 4
la $a0, str6
syscall

## Print Integer Sum
li $v0, 1
move $a0, $t5
syscall 

Close:

li $v0, 10 
syscall



