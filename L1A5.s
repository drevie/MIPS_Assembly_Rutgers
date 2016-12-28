.data
str1: .asciiz "Please enter N to be added: "
str2: .asciiz "\n Please enter a number to be multiplied: "
str3: .asciiz "\n Result: "
str4: .asciiz "\n"
str5: .asciiz "\n Program Finished" 


.text

main:


## Print str1
li $v0, 4           # load 4 to $v0 to begin printing
la $a0, str1        # load address of string to be printed
syscall   

## Input 1
li $v0, 5           # load 5 to $v0 to begin input
syscall 
addi $a0, $v0, 0    # move value to $t0 from $v0

addi $t0, $a0, 0    # create another N
addi $t5, $a0, 0    # create another N


Loop:

## Print str2
li $v0 4,           # load 4 to begin print
la $a0, str2        # load string 2 address
syscall

## Input
li $v0, 5           # load 5 to $v0 to begin input
syscall 
addi $t1, $v0, 0    # move value to $t1 from $v0

beq $t0, $t5, FirstTime



mult $t2, $t1       # multiply the next number
mflo $t2            # move the result into $t2

## Print str3
li $v0, 4           # lode print string code
la $a0, str3        # load str address
syscall

## Print contents of $t2
addi $a0, $t2, 0    # Move the product to $a0
li $v0, 1           # code for printing register
syscall

## Print str4
li $v0, 4           # lode print string code
la $a0, str4        # load str address
syscall


addi $t0, $t0, -1   # decrement addition count

beqz $t0, End       # end condition

j Loop              # Jump to Loop


FirstTime:
addi $t2, $t1, 0    # save the first value for multiplication
addi $t0, $t0, -1   # decrement N
j Loop



End:



## Print str5
li $v0, 4           # lode print string code
la $a0, str5        # load str address
syscall


li $v0, 10          # end the program
syscall 


