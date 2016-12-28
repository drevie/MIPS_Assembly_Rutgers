# Daniel Revie
# Assignment 5
# Febuary 19, 2016 

.data
str1: .asciiz "Please enter a string with the following requirements \n 1: Length between 6 and 10 characters \n 2: Include both upper and lower case characters \n"
str3: .asciiz "Your string was not the right amount of characters! \n"
Password: .space 100 
PassArray: .space 100
SuccessArray: .space 100 
str2: .asciiz "\nYou inputted: " 
alphabet: .asciiz "abcdefghijklmnopqrstuv "
ALPHABET: .asciiz "ABCDEFGhiJKLMNOPQRSTUV"
str4: .asciiz "No cap existed"

.text 

main:

## Str1 print protocol 
li $v0, 4
la $a0, str1
syscall 

## Read Password
li $v0, 8
la $a0, Password
syscall 
move $t0, $a0                 # save the string to $t0
##la $t2, PassArray
##sw $

## Read back input 
li $v0, 4
la $a0, str2
syscall 
la $a0, Password
move $a0, $t0 
li $v0, 4
syscall 

la $t0, Password               # load address of Password into $t0
li $t1, 0                      # initiate counter
li $s0, 7                      # minimum bound
li $s1, 14                     # maximum bound
li $s4, 26                     # letters in alphabet 
li $t7, 0                      # counter 
li $t6, 0                      # letter counter 

countChr:
	lb $t2, 0($t0)             # Load the first byte from address in $t0 
	beqz $t2, CountEnd        # if $t2 = 0 then go to label end
	addi $t0, 1                # increment address counter 
	addi $t1, $t1, 1           # increment counter 
	bgt $t1, $s0, Check        # jump to length check 
	
	
Check:
	bgt $t1, $s1, LengthFail   # string is too long 
	j countChr

CountEnd: 
	bgt $t1, $s1, LengthFail   # string is too long 
	j UpperCheck               # jump to upper case check 
	

LengthFail:
## Initialize fail message print
li $v0, 4
la $a0, str3
syscall 
j End                           # jump to end 

UpperCheck:	                    # Check if an uppercase is present
blt $t1, $s0, LengthFail        # if the length does not hit the minimum requirement jump out of loop 
li $s0, 0                       # restor $s0 
add $s0, $t1, $zero             # save letter count in $s0 
## Reset iterators 
li $t1, 0                       # reset iterators
la $t0, Password                # reload address to $t0 
la $t2, ALPHABET                # load upper case alphabet 



UpperLetterCheck:
	lb $t3, 0($t0)                  # load character of string 
	lb $t4, 0($t2)                  # load Uppercase letter 
	beq $t3, $t4, UpperSuccess      # upper matched 
	beq $t7, $s4, NextLetterUpper   # letter did not match 
	addi $t2, 1                     # increment ALPHABET 
	addi $t7, 1
	j UpperLetterCheck
	
NextLetterUpper:
	addi $t0, 1                 # increment string letter count 
	addi $t1, 1                 # increment counter 
	beq $t1, $s0, NoCapFail     # no capital letter exists 
	j UpperLetterCheck
	
UpperSuccess:
	addi $t1, 1                  # incrememnt coutner 
	addi $t0, 1                  # increment password
	addi $t2, 1                  # increment ALPHABET 
	j LowerCheck

LowerCheck:
	la $t2, alphabet             # load lower alphaber
	la $t0, Password             # load password 
	li $t1, 0 

LowerLetterCheck:
	lb $t3, 0($t0)                # load character of password 
	lb $t4, 0($t2)                # Load lowercase letter 
	beq $t3, $t4, LowerSuccess    # letter matched 
	beq $t2, $s4, NextLetterLower # letter did not match 
	addi $t2, 1                   # increment alphabet 
	j LowerLetterCheck 
	
NextLetterLower: 
	addi $t0, 1                   # increment password address 
	addi $t1, 1                   # increment counter 
	la $t2, alphabet
	beq $t0, $s0, NoLowFail       # lower case letter not in string 
	j UpperLetterCheck

LowerSuccess: 
	j TestDone
	

NoCapFail:
	## Load fail for caps 
	li $v0, 4
	la $a0, str4
	syscall 

TestDone: 

End:
## END PROGRAM
li $v0, 10 
syscall 