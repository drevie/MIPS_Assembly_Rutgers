## Daniel Revie 
## 2/8/2016



.data 0x10000000
.align 2
Array1: .word 0:9
str1: .asciiz "This is assignment 6 \n"
str2: .asciiz "The value of a["
str5: .asciiz "] is: "
str3: .asciiz "Arithmetic overflow"
str4: .asciiz "Enter n: "


.text 0x00400000
.align 2
.globl main

main:





## Print str1
li $v0, 4           # load 4 to $v0 to begin printing
la $a0, str1        # load address of string to be printed
syscall   

## Print str4
li $v0, 4
la $a0, str4
syscall

Restart:
## Read in N
li $v0, 5
syscall 
move $t6, $v0
addi $t6, 1
addi $s4, $t6, -1

li $s6, 1 


## assign array values
addi $t0, $zero 0    # value 0
addi $t1, $zero 1    # value 1
addi $t2, $zero 2    # value 2
addi $t3, $zero 4    # value N = 4
#addi $t6, $zero 10   # End value a[9] is the 10th element

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
beq $s7, $s6, Clean
add $t5, $t5 $a2      # a[n-1] + a[n-2] + a[n-3]
beq $s7, $s6, Clean

## save the result in the proper location
mul $a3 $t4 $v1       # $a3 = $t4 * 4
sw $t5, Array1($a3)

## increment N
addi $t4, $t4, 1

## repeat
j Loop


END:
mul $t6, $t6, $v1    # $t6 * 4
lw $t7, Array1($a3)

## print str2
li $v0, 4
la $a0, str2
syscall

## print value of answer 
li $v0, 1
move $a0, $s4
syscall 

# print str5
li $v0, 4
la $a0, str5
syscall

## Print contents of $t7
addi $a0, $t7, 0    # Move the product to $a0
li $v0, 1           # code for printing register
syscall

j Finish

Clean:

li $t0, 0
li $t1, 0
li $t2, 0
li $t3, 0
li $t4, 0
li $t5, 0
li $t6, 0
li $t7, 0

li $s0, 0
li $s1, 0
li $s2, 0
li $s3, 0
li $s4, 0
li $s5, 0
li $s6, 0
li $s7, 0

li $v0, 0
li $v1, 0
li $a0, 0
li $a1, 0
li $a2, 0
li $a3, 0

j Restart




Finish:
## End program
li $v0, 10
syscall



## Begin arithmetic overflow handling
.ktext 0x80000180


## Print overflow message 
#move $k0,$v0   # Save $v0 value
#move $k1,$a0   # Save $a0 value
li $v0, 4
la $a0, kstr0
syscall
move $v0,$k0   # Restore $v0
move $a0,$k1   # Restore $a0
mfc0 $k0,$14   # Coprocessor 0 register $14 has address of trapping instruction
addi $k0,$k0,4 # Add 4 to point to next instruction
mtc0 $k0,$14   # Store new address back into $14


	
## Print str1
li $v0, 4           # load 4 to $v0 to begin printing
la $a0, kstr1        # load address of string to be printed
syscall   

## Print str4
li $v0, 4
la $a0, kstr4
syscall

## Read in N
#li $v0, 5
#syscall 
#move $t6, $v0
#addi $t6, 1
#addi $s6, $t6, -1

li $s7, 1

eret


.kdata
kstr0: .asciiz "Arithmetic overflow\n"
kstr1: .asciiz "This is assignment 6 \n"
kstr4: .asciiz "Enter n: "

