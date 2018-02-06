#Calculator
#CODED BY TAHA SALMAN 

.data

str1: .asciiz "Calculator for MIPs \n"
str2: .asciiz "Press 'c' to clear and 'q' to quit:\n"
str3: .asciiz "\nResult: "
str4: .asciiz "Bye!"
hundred: .float 100
	.text
	.globl main

#TODO:
#main procedure, that will call your calculator
main:
	jal calc
	
	j exitProgram
#calculator procedure, that will deal with the input
	#2 cases you must consider:

	#  Number Operation Number <enter is pressed>
	#  Must display the result on the screen

	#  Operation Number <enter is pressed>
	#  uses prior result as the first number
	#  Returns the new result to the display

calc:
	#####PRINT STANDARD GREETINGS####
	la $a0, str1
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printLine
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	la $a0, str2			#print instructions
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printLine
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
									
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal startCalc
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack

startCalc:
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal readAndPrintInt
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	add $s5,$v0,$0				#store result of int read in s5
	j operateMe
	
operateMe:
	#take user input#
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readChar
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	add $a0,$v0,$0				#store user input in a0
	
	beq $a0,'q',exitProgram			#if input is q quitCalc
	beq $a0,'c',clearScreen			#if input is c clear screen
	beq $a0,'+',addOp
	beq $a0,'-',subOp
	beq $a0,'*',multOp
	beq $a0,'/',divOp
	
	j operateMe
addOp:
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	#take user input#
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal waitForSpace
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readAndPrintInt
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	mtc1 $s5,$f1				#store original s5 as coprocessor
	cvt.s.w $f1,$f1
	mtc1 $v0,$f2				#store v0 in f2
	cvt.s.w $f2,$f2
	
	add.s $f1,$f1,$f2
	l.s $f3,hundred
	mul.s $f1,$f1,$f3
	round.w.s $f1,$f1
	
	mfc1 $s5,$f1					#s5 now contains answer * 100 where 100 are last 2 digits
	#add $s5,$v0,$s5				#add new int to previous one stored at s5
	
	j calcComplete

subOp:
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	#take user input#
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal waitForSpace
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readAndPrintInt
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	mtc1 $s5,$f1				#store original s5 as coprocessor
	cvt.s.w $f1,$f1
	mtc1 $v0,$f2				#store v0 in f2
	cvt.s.w $f2,$f2
	
	sub.s $f1,$f1,$f2
	l.s $f3,hundred
	mul.s $f1,$f1,$f3
	round.w.s $f1,$f1
	
	mfc1 $s5,$f1					#s5 now contains answer * 100 where 100 are last 2 digits
	
	#sub $s5,$s5,$v0				#add new int to previous one stored at s5
	
	j calcComplete
subOp2:
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readAndPrintInt
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	mtc1 $s5,$f1				#store original s5 as coprocessor
	cvt.s.w $f1,$f1
	mtc1 $v0,$f2				#store v0 in f2
	cvt.s.w $f2,$f2
	
	sub.s $f1,$f1,$f2
	l.s $f3,hundred
	mul.s $f1,$f1,$f3
	round.w.s $f1,$f1
	
	mfc1 $s5,$f1					#s5 now contains answer * 100 where 100 are last 2 digits
	
	
	#sub $s5,$s5,$v0				#sub new int to previous one stored at s5
	
	j calcComplete
multOp:
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	#take user input#
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal waitForSpace
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readAndPrintInt
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	mtc1 $s5,$f1				#store original s5 as coprocessor
	cvt.s.w $f1,$f1
	mtc1 $v0,$f2				#store v0 in f2
	cvt.s.w $f2,$f2
	
	mul.s $f1,$f1,$f2
	l.s $f3,hundred
	mul.s $f1,$f1,$f3
	round.w.s $f1,$f1
	
	mfc1 $s5,$f1					#s5 now contains answer * 100 where 100 are last 2 digits
	
	#mult $s5,$v0				#add new int to previous one stored at s5
	#mflo $s5
	j calcComplete

divOp:
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	#take user input#
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal waitForSpace
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readAndPrintInt
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	mtc1 $s5,$f1				#store original s5 as coprocessor
	cvt.s.w $f1,$f1
	mtc1 $v0,$f2				#store v0 in f2
	cvt.s.w $f2,$f2
	
	div.s $f1,$f1,$f2
	l.s $f3,hundred
	mul.s $f1,$f1,$f3
	round.w.s $f1,$f1
	
	mfc1 $s5,$f1					#s5 now contains answer * 100 where 100 are last 2 digits
	
	#div $s5,$v0				#add new int to previous one stored at s5
	#mflo $s5
	j calcComplete
		
calcComplete:
	la $a0,str3
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printLine
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	add $a0,$s5,$0				
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printInt
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	addi $a0,$0,'\n'
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	li $t0,100
	div $s5,$t0
	mflo $s5
	j continueCalc
	
continueCalc:
	
	#READ CHAR TO DECIDE WHAT TO DO NOW#
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readChar
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	add $a0,$v0,$0
	beq $v0,'q',exitProgram			#if input is q quitCalc
	beq $v0,'c',clearScreen			#if input is c clear screen
	beq $v0,'+',addOp
	beq $v0,'-',checkIfSubOrInt
	beq $v0,'*',multOp
	beq $v0,'/',divOp
	
	slti $s1,$v0,48				#check if character is less than ascii val 48
	bne $s1,$0,continueCalc			#if its less than 48 then ignore the input
	slti $s1,$v0,58				#checks if character is less than ascii val 58
	beq $s1,$0,continueCalc			#if it is ignore the input
	
	j initForInt
	
#we can assume first input is negative. so lets keep that in mind
checkIfSubOrInt:
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar				#print character which is -
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	#READ CHAR TO DECIDE WHAT TO DO NOW#
ifin2:	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readChar
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	add $a0,$v0,$0
	beq $v0,' ',subOp2			        #go to subOp2 which doesnt wait for another space
	slti $s1,$v0,48				#check if character is less than ascii val 48
	bne $s1,$0,ifin2		#if its less than 48 then ignore the input
	slti $s1,$v0,58				#checks if character is less than ascii val 58
	beq $s1,$0,ifin2			#if it is ignore the input
	
	j initForIntNeg

initForIntNeg:

	add $s3,$0,$0				#store 0 in s3
	li $s0,10				#store 10 in t0
	li $s2,0				#load counter into t2
	li $s4,-1
	
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar				#print character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	add $s1,$v0,$0				#store the input in s1
	addi $s1,$s1,-48			
	mult $s3,$s0				#multiply accumulator s3 by multiplier
	mflo $s3				#update accumulator
	add $s3,$s3,$s1				#acc+=input
	addi $s2,$s2,1				#add 1 to counter
	
	jal rapiLoop
	
	add $s5,$v0,$0
	j operateMe
initForInt:
	add $s3,$0,$0				#store 0 in s3
	li $s0,10				#store 10 in t0
	li $s2,0				#load counter into t2
	add $s4,$0,$0
	
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar				#print character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	add $s1,$v0,$0				#store the input in s1
	addi $s1,$s1,-48			
	mult $s3,$s0				#multiply accumulator a0 by multiplier
	mflo $s3				#update accumulator
	add $s3,$s3,$s1				#acc+=input
	addi $s2,$s2,1				#add 1 to counter
	jal rapiLoop
	
	add $s5,$v0,$0
	j operateMe
waitForSpace:
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readChar
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	bne $v0,' ',waitForSpace
	
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4				#pop stack
	
	jr $ra
clearScreen:
	li $a0,'\f'
	jal printChar
	j calc
	
###READ AND PRINT INTEGER UNTIL IT SEES ' '####
readAndPrintInt:
	li $s3,0				#store 0 in s3
	li $s0,10				#store 10 in t0
	li $s2,0				#load counter into t2
	add $s4,$0,$0
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readChar				#read character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	beq $v0,'q',exitProgram			#if input is q quitCalc
	beq $v0,'c',clearScreen			
	beq $v0,' ',exitRap
	beq $v0,'\n',exitRap
	beq $v0,'-',setToNeg			#if the first symbol of the int is negative sign go to set to NEg
	slti $s1,$v0,48				#check if character is less than ascii val 48
	bne $s1,$0,rapiLoop			#if its less than 48 then ignore the input
	slti $s1,$v0,58				#checks if character is less than ascii val 58
	beq $s1,$0,rapiLoop			#if it is ignore the input
	
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar				#print character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	add $s1,$v0,$0				#store the input in s1
	addi $s1,$s1,-48			
	mult $s3,$s0				#multiply accumulator a0 by multiplier
	mflo $s3				#update accumulator
	add $s3,$s3,$s1				#acc+=input
	addi $s2,$s2,1				#add 1 to counter
	j rapiLoop
setToNeg:
	li $s4,-1
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar				#print character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	j rapiLoop
rapiLoop:
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal readChar				#read character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	beq $v0,' ',exitRap
	beq $v0,'\n',exitRap
	slti $s1,$v0,48				#check if character is less than ascii val 48
	bne $s1,$0,rapiLoop			#if its less than 48 then ignore the input
	slti $s1,$v0,58				#checks if character is less than ascii val 58
	beq $s1,$0,rapiLoop			#if it is ignore the input
	
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar				#print character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	add $s1,$v0,$0				#store the input in s1
	addi $s1,$s1,-48			
	mult $s3,$s0				#multiply accumulator s3 by multiplier
	mflo $s3				#update accumulator
	add $s3,$s3,$s1				#acc+=input
	addi $s2,$s2,1				#add 1 to counter
	j rapiLoop

exitRap:
	add $a0,$v0,$0
	addi $sp,$sp,-4
	sw $ra, 0($sp)				#push return address to stack
	jal printChar				#print character
	lw $ra 0($sp)	
	addi $sp,$sp,4				
	
	bne $s4,$0,negateMe
	add $v0,$s3,$0
	add $v1,$s2,$0
	jr $ra
negateMe:
	sub $s3,$0,$s3
	add $v0,$s3,$0
	add $v1,$s2,$0
	jr $ra

#driver for getting input from MIPS keyboard
readChar:
	lui $t0, 0xffff
readCharLoop:
	lw $t1, 0($t0)
	andi $t1,$t1,0x0001
	beq $t1,$0, readCharLoop
	lw $v0, 4($t0)
	jr $ra

#driver for putting output to MIPS display
#a0 stores the value to be written
printChar:
	lui $t0,0xffff
printCharLoop:
	lw $t1, 8($t0)
	andi $t1,$t1,0x0001
	beq $t1,$0,printCharLoop
	sw $a0, 12($t0)
	jr $ra
	
#prints entire string in a0
printLine:				#takes as input a string and then prints it char by char until it reaches null
	add $s0,$a0,$0			#save the string to be printed in s0		
printLineLoop:
	lb $a0, 0($s0)			#load the next char in s0 into a0
	
	beq $a0, $0, endPrint		#if reaches null char go to endPrint
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	addi $s0,$s0,1
	j printLineLoop
endPrint:
	jr $ra	


#assumes user has inputted a valid
printInt:
	#MUST CHECK IF INT IS NEGATIVE FIRST
	slt $t3,$a0,$0		#check if int is negative
	li $t0,1
	beq $t3,$t0,printIntNeg	#alternate initiation 
	add $t3,$a0,$0		#store in t3 the number entered
	li $t4,0		#store 1 in t4, t4 is counter
	li $t0,10
	
	div $t3,$t0	
	
	mflo $t3		#t3 now contains quotient of division
	mfhi $t1		#t1 contains remainder
	
	addi $t1,$t1,48		#convert t1 to char
	addi $sp,$sp,-4
	sw $t1, 0($sp)			#store char in stack
	addi $t4,$t4,1			# add 1 to counter
	
	j breakNum
printIntNeg:
	sub $t3,$0,$a0
	
	li $a0,'-'		   	#"print negative sign"
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	li $t4,0		#store 1 in t4, t4 is counter
	li $t0,10
	
	div $t3,$t0	
	
	mflo $t3		#t3 now contains quotient of division
	mfhi $t1		#t1 contains remainder
	
	addi $t1,$t1,48		#convert t1 to char
	addi $sp,$sp,-4
	sw $t1, 0($sp)			#store char in stack
	addi $t4,$t4,1			# add 1 to counter
	
	j breakNum
breakNum:
	div $t3,$t0	
	
	mflo $t3		#a0 now contains quotient of division
	mfhi $t1		#t1 contains remainder
	
	addi $t1,$t1,48		#convert t1 to char
	
	addi $sp,$sp,-4
	sw $t1, 0($sp)			#store char in stack
	
	addi $t4,$t4,1			# add 1 to counter
	
	beq $t3,$0,rebuildNum
	
	j breakNum

rebuildNum:
	beq $t4,$0,endPrintInt
	beq $t4,2,printDec
	lw $a0,0($sp)
	addi $sp,$sp,4
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	addi $t4,$t4,-1
	
	j rebuildNum

printDec:
	addi $a0,$0,'.'
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	lw $a0,0($sp)
	addi $sp,$sp,4
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)			#push return address to stack
	jal printChar
	lw $ra 0($sp)
	addi $sp,$sp,4			#pop stack
	
	addi $t4,$t4,-1
	
	j rebuildNum
endPrintInt:
	jr $ra
exitProgram:
	#li $a0,'\f'
	#jal printChar
	la $a0, str4
	jal printLine
	nop
