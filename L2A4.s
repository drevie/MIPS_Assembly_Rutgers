## Daniel Revie 
## Assignment 4
## 2/9/2016

.data
str1: .asciiz "Please enter the number of lines you would like: " 
star: .asciiz "*"
space: .asciiz " "
NewLine: .asciiz "\n"

.text 

main:

## Begin str1 print
li $v0, 4
la $a0, str1
syscall 

## Begin line count input
li $v0, 5 
syscall 
move $t0, $v0


li $t6, 1                       # Create star count
li $t4, 0                       # Create space count
li $t7, 0                       # Create row iterator


## Begin even or odd test of input
li $t1, 2                       # create 2 for test
div $t0, $t1                    # divide user input by 2 
mfhi $t3                        # move remainder to $t3 for even/odd test 
mflo $t4                        # move quotient to $t4
add $s2, $t4, $zero             # save N/2 in $s2
beqz $t3, EvenFirstHalf         # jump to even on no remainder

## ELSE ODD SEQUENCE OCCURS 
add $s6, $t0, $zero              # move user input to $s6 for manipulation
addi $s6, -1                     # (n-1) for odd algorithms
div $s6, $t1                     # (n-1) / 2 for algorithm 
mflo $s6                         # move quotient to $s6 ALSO SPACES 
addi $s7, $s6, 1                 # [(n-1) / 2] + 1 middle row algorithm 
addi $s6, 1                      # prepare space count for first iteration 

j OddFirstHalf                   # otherwise jump to odd

OddSecondHalf:
	beqz $t8, OddSwitchIteration
	li $t5, 0                       # Create space iterator
	li $s1, 0                       # create star iterator
	addi $s6, 1                     # Reverse increment spaces 
	beq $t0, $t7, Done              # If N = Iterator ALL print sequences COMPLETE
	j OddSpacePrint
	
	
	
OddFirstHalf:
	beq $t7, $s7, OddSecondHalf
	
	## CREATE AND RESTORE ITERATORS
	li $t5, 0                       # Create space iterator
	li $s1, 0                       # create star iterator
	addi $s6, -1                    # SPACES = (n/2) - 1

	OddSpacePrint:
		beq $t5, $s6, OddStarPrint # branch to star print when space counter equals SPACES
		
		## Space print initiation 
		li $v0, 4               # initialize print register
		la $a0, space           # load space address 
		syscall                 # PRINT SPACE
		 
		addi $t5, 1              # increment space coutner
		j OddSpacePrint             # Jump back to space print -> branch not satisfied
	
	OddStarPrint:
		beq $s1, $t6, OddNewRow    # When star coutner equals star level jump to new row
		
		## Star print initiation 
		li $v0, 4               # initialize print register
		la $a0, star            # load star address 
		syscall                 # PRINT STAR
		
		addi $s1, 1             # increment star iterator
		j OddStarPrint             # jump back to star print (loop)
		
	OddNewRow:
		## Star print initiation 
		beqz $s4, OddFirstHalfSwitch     # test wheter this a first or second half print protocol 
		
		
		li $v0, 4               # initialize print register
		la $a0, NewLine         # load new line address 
		syscall                 # PRINT NEWLINE
		addi $t6, -2            # subtract two stars to keep diamond formation
		addi $t7, 1 		    # increment overall iterator
		j OddSecondHalf
		
		
		OddFirstHalfSwitch:
		li $v0, 4               # initialize print register
		la $a0, NewLine         # load star address 
		syscall                 # PRINT NEWLINE
		addi $t6, 2             # add two stars to keep diamond formation
		addi $t7, 1 		    # increment overall iterator
		j OddFirstHalf              # jump back to EvenRows protocol
	
	OddSwitchIteration:
		addi $t6, -4            # subtract two stars to keep diamond formation
		add $s6, 1
		addi $t8, 1             # increment switch for star decrementation
		addi $s4, 1             # turn on switch for NewRow protocol
		li $t5, 0               # Create space iterator
		li $s1, 0               # create star iterator
		j OddSpacePrint
	
	
	
	
	
	
EvenSecondHalf:
	beqz $s4, SwitchIteration       # Switch iteration occurs must decrement star coutner first 
	li $t5, 0                       # Create space iterator
	li $s1, 0                       # create star iterator
	addi $t4, 1                     # Reverse increment spaces 
	beq $t0, $t7, Done              # If N = Iterator ALL print sequences COMPLETE
	j SpacePrint


EvenFirstHalf:

	beq $s2, $t7, EvenSecondHalf          # If N/2 = Iterator first print sequence COMPLETE
	## calculate spaces
	addi $t4, -1                          # SPACES = (n/2) - 1
	 
	## CREATE AND RESTORE ITERATORS
	li $t5, 0                       # Create space iterator
	li $s1, 0                       # create star iterator
	
	SpacePrint:
		beq $t5, $t4, StarPrint # branch to star print when space counter equals SPACES
		
		## Space print initiation 
		li $v0, 4               # initialize print register
		la $a0, space           # load space address 
		syscall                 # PRINT SPACE
		 
		addi $t5, 1              # increment space coutner
		j SpacePrint             # Jump back to space print -> branch not satisfied
	
	StarPrint:
		beq $s1, $t6, NewRow    # When star coutner equals star level jump to new row
		
		## Star print initiation 
		li $v0, 4               # initialize print register
		la $a0, star            # load star address 
		syscall                 # PRINT STAR
		
		addi $s1, 1             # increment star counter
		j StarPrint             # jump back to star print (loop)
		
	NewRow:
		## Star print initiation 
		beqz $s4, FirstHalf     # test wheter this a first or second half print protocol 
		
		
		li $v0, 4               # initialize print register
		la $a0, NewLine         # load new line address 
		syscall                 # PRINT NEWLINE
		addi $t6, -2            # subtract two stars to keep diamond formation
		addi $t7, 1 		    # increment overall iterator
		j EvenSecondHalf
		
		
		FirstHalf:
		li $v0, 4               # initialize print register
		la $a0, NewLine         # load star address 
		syscall                 # PRINT NEWLINE
		addi $t6, 2             # add two stars to keep diamond formation
		addi $t7, 1 		    # increment overall iterator
		j EvenFirstHalf              # jump back to EvenRows protocol
	
	SwitchIteration:
		addi $t6, -2            # subtract two stars to keep diamond formation
		addi $s4, 1             # increment switch for star decrementation
		li $t5, 0               # Create space iterator
		li $s1, 0               # create star iterator
		j SpacePrint

	
	Done: 
		li $v0, 10 
		syscall 
		

	