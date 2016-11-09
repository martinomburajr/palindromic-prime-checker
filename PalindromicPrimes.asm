#OMBMAR001

.data
startNumMess:  .asciiz     "Enter the starting point N: \n"
startNum2Mess:  .asciiz     "Enter the ending point M: \n"
palPrimesMess: .asciiz "The palindromic primes are:\n"
cr: .asciiz "\n"

initia: .word 2 #initial counter
N:   .word       0    # entered number
M:   .word       0    # entered number

.text
main:

#START MESSAGE
    la $a0,startNumMess  
    li $v0, 4
    syscall


#ENTER NUMBER
    li $v0, 5
    syscall
    sw $v0, N    #SWAP NUMBER TO MEMORY
    
    
    #START MESSAGE 2
    la $a0,startNum2Mess  
    li $v0, 4
    syscall


#ENTER NUMBER
    li $v0, 5
    syscall
    sw $v0, M     #SWAP NUMBER TO MEMORY
    
    
        #START MESSAGE 2
    la $a0,palPrimesMess  
    li $v0, 4
    syscall
    
    
    lw $s0,N #lower bound
    #add $s0,$s0,1
    lw $s1,M # upperbound
    sub $s1,$s1,1
    
    
    
   ############################## #LOOPPS ##############################
    
    loopPredicate:
    
   bgt $s0,$s1,end
    beq $s0,$s1,end # IF LOWER == HIGHER go to done
    add $s0,$s0,1 ##INCREMENT to avoid using the initial input value
    
    
    j checkPalindrome 
    j end
    
  
  #########################CHECK PALINDROME: SETS UP THE PALINDROME SEQUENCE##################
    checkPalindrome:  
    li $t2, 0       #immediately set t2 to 0
    li $t3, 10          # t3 = 10
    li $t0, 0       # t0 = 0

    move $t4, $s0       # move the counter to t4

    jal reverse	#go straight to reverse
    j end

#######################REVERSE: REVERSES PALINDROME#######################################

    reverse:    #reverse the number
    bgtz $t4, reverseFunction   # while t4 is greater than zero, go to reverseFunction else compare
    j compare


################# REVERSEFUNCTION: REVERSES THE INTEGER #########################
reverseFunction:
    div $t4, $t3        # DIVIDE current counter by 10
    mfhi $t6        # store the hi value in t6
    mult $t2, $t3       # multiply 0 * 10
    mflo $t2        # store the low of the multiplication
    add $t2, $t2, $t6   # add up t2 to t6
    div $t4, $t3        # divide the counter by 10
    mflo $t4        # store the low 

    j reverse


########### COMPARE: COMPARES THE TWO INTEGERS ########################
compare:
	lw $t8,initia #Loads the initial value
    beq $t2, $s0, pal
    j notPalindrome

############### PAL : IF PALINDROME CHECK TO SEE IF ITS PRIME#####################
pal:
	beq $t8,$s0,primePalin ##IF THE INITIAL AND THE PALINDROME ARE EQUAL, THEN GO TO NOPAL IF A PRIME HASNT BEEN FOUND
	rem $s7,$s0,$t8
	beqz $s7, notPalindrome

	add $t8,$t8,1
	j pal

##### primePalin: IF PRIME AND PALINDROME, PRINT OUTPUT ##########################
primePalin:
    move $a0,$s0    #print pal
    li $v0, 1
    syscall
    
    la $a0,cr #Print carraigereturn
    li $v0,4
    syscall
    
     j loopPredicate
	

############### IF NOT PALINDROME: GOOO TO START OF LOOP ###############################
notPalindrome:
    j loopPredicate

######## END: TERMINATE PROGRAM ################
end:
   	li $v0,10
	syscall #Exit
