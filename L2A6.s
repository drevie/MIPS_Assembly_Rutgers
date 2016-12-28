# Daniel Revie
# Febuary 20, 2016
# Assignmnet 6 

.data
str1: .asciiz "Please enter your hex string: " 
HexString: .space 100 




.text 

# Str1 pring protocol
li $v0, 4
la $a0, str1
syscall 

# Read in HexString
li $v0, 8
la $a0, HexString
syscall 
move $t0, $a0              # Store HexString in $t0 


