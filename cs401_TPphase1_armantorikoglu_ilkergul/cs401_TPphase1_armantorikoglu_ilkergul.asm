.data
            #    0    1    2    3    4    5    6    7    8    9    a    b    c    d     e   f
sboxzero: .word 0xf, 0x4, 0x5, 0x8, 0x9, 0x7, 0x2, 0x1, 0xa, 0x3, 0x0, 0xe, 0x6, 0xc, 0xd, 0xb
sboxone: .word 0x4, 0xa, 0x1, 0x6, 0x8, 0xf, 0x7, 0xc, 0x3, 0x0, 0xe, 0xd, 0x5, 0x9, 0xb, 0x2
sboxtwo: .word 0x2, 0xf, 0xc, 0x1, 0x5, 0x6, 0xa, 0xd, 0xe, 0x8, 0x3, 0x4, 0x0, 0xb, 0x9, 0x7
sboxthree: .word 0x7, 0xc, 0xe, 0x9, 0x2, 0x1, 0x5, 0xf, 0xb, 0x6, 0xd, 0x0, 0x4, 0x8, 0xa, 0x3
fulltable: .word 0xf427, 0x4afc, 0x51ce, 0x8619, 0x9852, 0x7f61, 0x27a5, 0x1cdf, 0xa3eb, 0x3086, 0x0e3d, 0xed40, 0x6504, 0xc9b8, 0xdb9a, 0xb273

randNumber: .asciiz "\nRandomly selected number: "
dashline: .asciiz  "\n - - - - - - - - - - - - - - - - -"
welcoming: .asciiz  "\Welcome to the CS401 Project Phase I\n"
preference: .asciiz  "\Select one of the options below for table method\nFor single table method please enter 0\nFor multiple table method please enter 1\nYour preference is: "
Sboxresult: .asciiz "\nThe result of S(x) is  "
Linearresult: .asciiz "\nThe result of L(x) is  "
finishline: .asciiz  "\nPhase I program is completed"

.text

main:
	la $a0,  welcoming         
      	li $v0,4
      	syscall  

        la $a0,  preference        
      	li $v0,4
      	syscall  
      	
        li $v0, 5		#preference selection input
	syscall
	move $s0, $v0		#s0 = 0 if singletable 1 for multi-table
	move $s2, $zero 	# counter of loop
	
forLoopTest:
	beq $s2, 100, exit_loop
	#sll $t5, $s2, 2
	li $a1, 65536  		#The range is between 0 to 65535.
    	li $v0, 42  		#generates the random number.
    	syscall
	
	move $t0, $a0
	la $a0,  randNumber
      	li $v0,4
      	syscall
      	
	move $a0, $t0
	li $v0, 34
        syscall
      
      
	beq $s0, $zero, singletablebranch	# if else part
	jal multitablemethod
	j secondphase

singletablebranch:
	jal singletablemethod
	
secondphase:
	move $t0, $v0
	la $a0,  Sboxresult			# the result of S(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t0
      	li $v0, 34 				# print result of S(x)
	syscall
	
	la $a0,  Linearresult			# the result of L(x) is
      	li $v0,4
      	syscall
      	move $a0, $t0
	
	jal linearfunction
	move $a0, $v0
        li $v0, 34
        syscall
        
        la $a0,  dashline			# the result of S(x) is
      	li $v0,4
      	syscall
	
	addi $s2, $s2, 1
	j forLoopTest
	
exit_loop:
	la $a0,  finishline        
      	li $v0,4
      	syscall  
	li $v0, 10
	syscall
      		
multitablemethod:
	subi $sp, $sp, 12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s2, 8($sp)

	la $s0, sboxzero # s4 => base address of sbox0
	la $s1, sboxone # s4 => base address of sbox1
	la $s2, sboxtwo # s4 => base address of sbox2
	la $s3, sboxthree # s4 => base address of sbox3

	# function input: 16 bit integer -> 4 hex digits

	# a0 is like 0000 0000 0000 0000 1001 1010 1111 0010
	# a0 is like 0000 0000 0000 0000 0000 0000 0000 1010
	# get the first hex digit => bitwise AND with  0000 0000 0000 0000 1111 0000 0000 0000 then right shift 12 times
	# rest is the same

	addi $t0, $zero, 61440 # will get the first hex
	addi $t1, $zero, 3840 # will get the second hex
	addi $t2, $zero, 240 # will get the third hex
	addi $t3, $zero, 15 # will get the forth hex

	and $t4, $a0, $t0
	sra $t4, $t4, 12

	and $t5, $a0, $t1
	sra $t5, $t5, 8

	and $t6, $a0, $t2
	sra $t6, $t6, 4

	and $t7, $a0, $t3
	add $t8, $zero, $zero

	# from index get the corresponding sbox element
	# element index = base addr + 4 * index

	sll $t4, $t4, 2
	add $t4, $t4, $s0

	sll $t5, $t5, 2
	add $t5, $t5, $s1

	sll $t6, $t6, 2
	add $t6, $t6, $s2

	sll $t7, $t7, 2
	add $t7, $t7, $s3


	# now get the sbox results
	lw $t0, 0($t4)
	lw $t1, 0($t5)
	lw $t2, 0($t6)
	lw $t3, 0($t7)

	# t0 is like 0000 0000 0000 0000 0000 0000 0000 1011
	# make it 0000 0000 0000 0000 1011 0000 0000 0000

	sll $t0, $t0, 12
	sll $t1, $t1, 8
	sll $t2, $t2, 4

	xor $t8, $t0, $t1
	xor $t8, $t8, $t2
	xor $t8, $t8, $t3

	add $v0, $t8, $zero # prints


  	lw $s2, 8($sp)		#restore register $s2
  	lw $s0, 4($sp)		#restore register $s0
  	lw $ra, 0($sp)		#restore the return address
  	addi $sp, $sp, 12	#pop three items
  	jr $ra			#return to the caller
  	
 singletablemethod:
 	subi $sp, $sp, 12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s2, 8($sp)
	
	la $s0, fulltable
	#addi $s1, $s0, 64  # s4 => base address of sbox1
	#addi $s2, $s0, 128 # s4 => base address of sbox2
	#addi $s3, $s0, 192 # s4 => base address of sbox3
	
	addi $t0, $zero, 61440 # will get the first hex
	addi $t1, $zero, 3840 # will get the second hex
	addi $t2, $zero, 240 # will get the third hex
	addi $t3, $zero, 15 # will get the forth hex
	
	and $t4, $a0, $t0
	sra $t4, $t4, 12

	and $t5, $a0, $t1
	sra $t5, $t5, 8

	and $t6, $a0, $t2
	sra $t6, $t6, 4

	and $t7, $a0, $t3
	add $t8, $zero, $zero
	
	# from index get the corresponding sbox element
	# element index = base addr + 4 * index

	sll $t4, $t4, 2
	add $t4, $t4, $s0

	sll $t5, $t5, 2
	add $t5, $t5, $s0

	sll $t6, $t6, 2
	add $t6, $t6, $s0

	sll $t7, $t7, 2
	add $t7, $t7, $s0


	# now get the sbox results
	lw $t0, 0($t4)
	lw $t1, 0($t5)
	lw $t2, 0($t6)
	lw $t3, 0($t7)

	# t0 is like 0000 0000 0000 0000 0000 0000 0000 1011
	# make it 0000 0000 0000 0000 1011 0000 0000 0000

	and $t0, $t0, 61440
	and $t1, $t1, 3840
	and $t2, $t2, 240
	and $t3, $t3, 15
	

	xor $t8, $t0, $t1
	xor $t8, $t8, $t2
	xor $t8, $t8, $t3

	add $v0, $t8, $zero # prints

  	lw $s2, 8($sp)		#restore register $s2
  	lw $s0, 4($sp)		#restore register $s0
  	lw $ra, 0($sp)		#restore the return address
  	addi $sp, $sp, 12	#pop three items
  	jr $ra			#return to the caller
	
 linearfunction:
 
 	add $t0, $a0, $zero
  	# right shift stage
 	ror $t0, $t0, 6 # right shift
 	
 	# 0000 0000 0000 0000 1111 0100 0010 1101   65209
 	# 0000 0000 0000 0000 1011 0111 1101 0000   istenen
 	# 1011 0100 0000 0000 0000 0011 1101 0000    shiftin sonucu = t0
 	# 16 bit logical right shift
 	# 0000 0000 0000 0000 1011 0100 0000 0000 
 	# 0000 0000 0000 0000 0000 0011 1111 1111  = 1023
 	srl $t1, $t0, 16
 	and $t0, $t0, 1023
 	xor $t1, $t1, $t0  	# $t1 = (X >>> 6)
 	
 	# left shift stage
 	rol $t2, $a0, 6 # left shift
 	# 0000 0000 0000 0000 1111 0100 0010 1101 
 	# 0000 1011 0111 1101
 	# 0000 0000 0011 1101 0000 1011 0100 0000	= t2
 	# after 16 bit right shift
 	# 0000 0000 0000 0000 0000 0000 0011 1101
 	
 	srl $t3, $t2, 16
 	and $t2, $t2, 65472
 	xor $t2, $t2, $t3    # $t2 = (X <<< 6)
 	
 	# Final Part
 	
 	xor $t4, $a0, $t2  # left shift xor
 	xor $t4, $t4, $t1	# right shift xor
 	add $v0, $zero, $t4
 	jr $ra