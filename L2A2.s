## Daniel Revie
## Assignment 2

.data
str1: .asciiz "The highest prime number before 300 is: "

## Write a program to print out the largest prime number which is smaller than 300

.text

main:

li $t0, 1              # create 1 constant
li $t1, 3              # create 3 constant
li $t2, 0              # initialize N counter
li $t3, 2              # initialize divisor coutner K
li $t4, 300            # end case

### Start the prime test ###
PrimeTest:

beq $t4, $t2, Complete           # End case test complete

## Restore needed variables
li $t5, 0
li $t3, 2

## Define first two base cases 
ble $t2, $t1 NotPrime  # n < = 1 --> NOT PRIME
ble $t2, $t1 Prime     # n < = 3 --> PRIME

## Begin divide loop ## 
DivideLoop:
div $t2, $t3          # divide N by K 
mfhi $t5              # move HI to $t5
beqz $t5, NotPrime    # if no remainder infers NOT PRIME jump to NotPrime
addi $t3, 1           # if there is a remainder increment divsor and repeat
beq $t2, $t3, Prime   # K = N implies PRIME integer found jump to Prime case 
j DivideLoop




## Define not prime case ##
NotPrime: 
	addi $t2, 1        # increment number but do not save -- not prime
	j PrimeTest        # jump back to test loop
	
## Define prime case ## 
Prime:
	li $s0, 0
	add $s0, $s0, $t2      # save the prime number in $s0
	addi $t2, 1            # increment N counter
	j PrimeTest            # return to PrimeTest

## Define completed case ## 
Complete: 

## Bein print process
li $v0, 4 
la $a0, str1
syscall 

## Begin int print process
li $v0, 1
add $a0, $zero, $s0
syscall 

## END
li $v0, 10
syscall 