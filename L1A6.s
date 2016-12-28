## Daniel Revie 
## 2/8/2016

.data 0x10000000
.align 2
Array1: .word 0:9
str1: .asciiz "This is assignment 6 \n"
str2: .asciiz "The value of a[9] is: "

.text 0x00400000
.align 2
.globl main

main:


## Print str1
li $v0, 4           # load 4 to $v0 to begin printing
la $a0, str1        # load address of string to be printed
syscall   

## assign array values
addi $t0, $zero 0    # value 0
addi $t1, $zero 1    # value 1
addi $t2, $zero 2    # value 2
addi $t3, $zero 4    # value N = 4
addi $t6, $zero 10   # End value a[9] is the 10th element

## byte addressing issue
mul $a0, $t0, $t3    # $t0 *4
mul $a1, $t1, $t3    # $t1 *4
mul $a2, $t2, $t3    # $t2 *4

## store first 3 elements of the array 
sw $t0, Array1($a0)  # a[0] = 0
sw $t1, Array1($a1)  # a[1] = 1
sw $t1, Array1($a2)  # a[2] = 1 

addi $v1 $zero 4    # get value 4

addi $t4, $zero 3
## begin loop algoirthm to generate rest of array values
Loop:


## End condition
beq $t4, $t6 END

## generate n - k
addi $t0, $t4 -1      # n-1
addi $t1, $t4 -2      # n-2
addi $t2, $t4 -3      # n-3

## byte addressing issue
 mul $t0, $t0, $v1    # $t0 *4
 mul $t1, $t1, $v1    # $t1 *4
 mul $t2, $t2, $v1    # $t2 *4

## store the values
lw $a0, Array1($t0)  # a[n-1]
lw $a1, Array1($t1)  # a[n-2]
lw $a2, Array1($t2)  # a[n-3]

## begin addition
add $t5, $a0 $a1      # a[n-1] + a[n-2]
add $t5, $t5 $a2      # a[n-1] + a[n-2] + a[n-3]

## save the result in the proper location
mul $a3 $t4 $v1       # $a3 = $t4 * 4
sw $t5, Array1($a3)

## increment N
addi $t4, $t4, 1

## repear
j Loop
++
END:
mul $t6, $t6, $v1    # $t6 * 4
lw $t7, Array1($a3)

## print str2
li $v0, 4
la $a0, str2
syscall

## Print contents of $t7
addi $a0, $t7, 0    # Move the product to $a0
li $v0, 1           # code for printing register
syscall

## End program
li $v0, 10
syscall