.data

str1: .asciiz "Hello, world \n"
str2: .asciiz "Please input a string \n"
str3: .asciiz "The string you inputted was: \n"
str4: .asciiz "This was assignment 4"

string_space: .space 100


.text

main: 

## Print 1
li $v0, 4            # system call code for printing string = 4
la $a0, str1         # load address of string to be printed into $a0
syscall              # print the string 


## Print 2
li $v0, 4            # system call code for printing string = 4
la $a0, str2         # load address of string to be printed into $a0
syscall              # print the string 

## Read 1 
li $v0, 8            # set up for read string
la $a0, string_space # load byte space for string
move $t0, $a0 
syscall  

##Print 3 
li $v0, 4            # prepare to print string
la $a0, str3 	     # load string address
syscall
li $v0, 4            # prepare to print
la $a0, string_space # load address of inputted string
syscall



## Print 4
li $v0, 4            # system call code for printing string = 4
la $a0, str4         # load address of string to be printed into $a0
syscall              # print the string 

li $v0, 10           # terminate the program
syscall 

