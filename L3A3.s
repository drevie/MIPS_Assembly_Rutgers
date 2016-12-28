## Daniel Revie
## 3/8/2016
## Lab 3 A3

.data
str1: .asciiz "Please enter the size of your array: "
str2: .asciiz "Please enter integer: "

.text

main:

## Print str 1
li $v0, 4
la $a0, str1
syscall 

## Read array size
li $v0, 5
syscall 
move $a0, $v0 

## Allocate array space 
li $v0, 9
syscall 

## address of space is now in $v0 
## move address of array to $a1 
move $s1, $v0 	


arrayLoop:

## Print str2 
li $v0, 4
la $a0, str2
syscall 

## Read integer 
li $v0, 5
syscall 
sw $v0, $s1 


li $v0 10
syscall 
	