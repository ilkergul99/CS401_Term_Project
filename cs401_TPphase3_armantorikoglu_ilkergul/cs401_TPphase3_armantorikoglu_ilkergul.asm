.data
            #    0    1    2    3    4    5    6    7    8    9    a    b    c    d     e   f
sboxzero: .word 0xf, 0x4, 0x5, 0x8, 0x9, 0x7, 0x2, 0x1, 0xa, 0x3, 0x0, 0xe, 0x6, 0xc, 0xd, 0xb
sboxone: .word 0x4, 0xa, 0x1, 0x6, 0x8, 0xf, 0x7, 0xc, 0x3, 0x0, 0xe, 0xd, 0x5, 0x9, 0xb, 0x2
sboxtwo: .word 0x2, 0xf, 0xc, 0x1, 0x5, 0x6, 0xa, 0xd, 0xe, 0x8, 0x3, 0x4, 0x0, 0xb, 0x9, 0x7
sboxthree: .word 0x7, 0xc, 0xe, 0x9, 0x2, 0x1, 0x5, 0xf, 0xb, 0x6, 0xd, 0x0, 0x4, 0x8, 0xa, 0x3
fulltable: .word 0xf427, 0x4afc, 0x51ce, 0x8619, 0x9852, 0x7f61, 0x27a5, 0x1cdf, 0xa3eb, 0x3086, 0x0e3d, 0xed40, 0x6504, 0xc9b8, 0xdb9a, 0xb273
testVectorIV: .word 0x3412, 0x7856, 0xBC9A, 0xF0DE
testVectorKey: .word 0x2301, 0x6745, 0xAB89, 0xEFCD, 0xDCFE, 0x98BA, 0x5476, 0x1032
testPlain: .word 0x1100, 0x3322, 0x5544, 0x7766, 0x9988, 0xBBAA, 0xDDCC, 0xFFEE


randNumber: .asciiz "Selected number's hexadecimal version is: "
randNumber2: .asciiz "Numbers' hexadecimal versions are as follows: "
dashline: .asciiz  "\n - - - - - - - - - - - - - - - - -"
welcoming: .asciiz  "\Welcome to the CS401 Project Phase III"
preference: .asciiz  "\Select one of the options below for table method\nFor single table method please enter 0\nFor multiple table method please enter 1\nYour preference is: "
Sboxresult: .asciiz "\nThe result of S(x) is  "
Fboxresult: .asciiz "\nThe result of F(x) is  "
Linearresult: .asciiz "\nThe result of L(x) is  "
finishline: .asciiz  "\nPhase II program is completed"
phase2line: .asciiz  "\nSelect a number for F(X): "
phase2line2: .asciiz  "\nSelect the numbers for W(X)\nX: "
phase2line3: .asciiz  "A: "
phase2line4: .asciiz  "B: "
phase2line5: .asciiz  "C: "
phase2line6: .asciiz  "D: "
phase2line3p: .asciiz  "\nA: "
phase2line4p: .asciiz  "\nB: "
phase2line5p: .asciiz  "\nC: "
phase2line6p: .asciiz  "\nD: "
phase2line2p: .asciiz  "\nX: "
wboxresult: .asciiz "\nThe result of W(X, A, B, C, D) is  "
statevectorresult: .asciiz "\nThe state vector is initialized to:   "
ciphertextresult: .asciiz "\nCipher Text is encrypted to:   "
comma: .asciiz ", "
.text

main:
	la $a0,  welcoming         
      	li $v0,4
      	syscall  

        la $a0,  phase2line        
      	li $v0,4
      	syscall  
      	
        li $v0, 5		#number input
	syscall
	move $a0, $v0		
	
	move $t0, $a0
	la $a0,  randNumber
      	li $v0,4
      	syscall
      	
	move $a0, $t0
	li $v0, 34
        syscall
        
        jal singletablemethod
	move $a0, $v0
        
        jal linearfunction
        move $t0, $v0
	la $a0,  Fboxresult			# the result of F(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t0
      	li $v0, 34 				# print result of F(x)
	syscall
	
	# ----- Now it's time for the second function of the second phase --------
	
	la $a0,  phase2line2        
      	li $v0,4
      	syscall 
      	
      	li $v0, 5		#number input X
	syscall
	move $t0, $v0
	
	la $a0,  phase2line3        
      	li $v0,4
      	syscall 
      	
      	li $v0, 5		#number input A
	syscall
	move $t1, $v0
	
	la $a0,  phase2line4        
      	li $v0,4
      	syscall 
      	
      	li $v0, 5		#number input B
	syscall
	move $t2, $v0

	la $a0,  phase2line5        
      	li $v0,4
      	syscall 
      	
      	li $v0, 5		#number input C
	syscall
	move $t3, $v0
	
	la $a0,  phase2line6        
      	li $v0,4
      	syscall 
      	
      	li $v0, 5		#number input D
	syscall
	move $t4, $v0
	
	# ------ Print Numbers -------
	la $a0,  randNumber2
      	li $v0,4
      	syscall
	
	la $a0,  phase2line2p			# the result of F(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t0
      	li $v0, 34 				# print result of F(x)
	syscall
	
	la $a0,  phase2line3p			# the result of F(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t1
      	li $v0, 34 				# print result of F(x)
	syscall
	
	la $a0,  phase2line4p			# the result of F(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t2
      	li $v0, 34 				# print result of F(x)
	syscall
	
	la $a0,  phase2line5p			# the result of F(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t3
      	li $v0, 34 				# print result of F(x)
	syscall
	
	la $a0,  phase2line6p			# the result of F(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t4
      	li $v0, 34 				# print result of F(x)
	syscall
	
	# ------ Print Numbers -------
	
	xor $a0, $t0, $t1	# X (+) A
	move $a1, $t2		# B
	move $a2, $t3		# C
	move $a3, $t4		# D
	
	jal wfunctionmethod
	move $t0, $v0
	la $a0,  wboxresult			# the result of W(x) is
      	li $v0,4
      	syscall
      	
      	move $a0, $t0
      	li $v0, 34 				# print result of W(x)
	syscall
	
	
	# ----- Now it's time for the third function of the second phase --------
	la $s0, testVectorIV
	la $s1, testVectorKey
	
	# load iv vector
	lw $a0, 0($s0)
	sll $a0, $a0, 16
	lw $t2, 4($s0)
	xor $a0, $a0, $t2
	
	lw $a1, 8($s0)
	sll $a1, $a1, 16
	lw $t2, 12($s0)
	xor $a1, $a1, $t2
	
	# load key vector
	lw $a2, 0($s1)
	sll $a2, $a2, 16
	lw $t2, 4($s1)
	xor $a2, $a2, $t2
	
	lw $a3, 8($s1)
	sll $a3, $a3, 16
	lw $t2, 12($s1)
	xor $a3, $a3, $t2
	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1,  16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	jal initializestatevector
	
	# return a0, a1, v0, v1
	srl $t0, $a0, 16
	and $t1, $a0, 65535
	srl $t2, $a1, 16
	and $t3, $a1, 65535
	srl $t4, $v0, 16
	and $t5, $v0, 65535
	srl $t6, $v1, 16
	and $t7, $v1, 65535
	
	# print the result vector:
	la $a0, statevectorresult        
      	li $v0,4
      	syscall 
      	
      	move $a0, $t0
        li $v0,34
      	syscall 	
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t1
        li $v0,34
      	syscall
      	
      	la $a0, comma         
      	li $v0,4
      	syscall	
      	
      	move $a0, $t2
        li $v0,34
      	syscall 	 	
	
	la $a0, comma         
      	li $v0,4
      	syscall
	
	move $a0, $t3
        li $v0,34
      	syscall
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t4
        li $v0,34
      	syscall
      	
        la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t5
        li $v0,34
      	syscall
      
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
	move $a0, $t6
        li $v0,34
      	syscall
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t7
        li $v0,34
      	syscall
      	
      	
#--------- PHASE III Starts Here --------
	
	la $s0, testPlain
	lw $t8, 0($s0)	
	la $s1, testVectorKey
	
	# load iv vector
	move $a0, $t0			#Load State Vector 0
	sll $a0, $a0, 16		
	xor $a0, $a0, $t1		#Load State Vector 1
	
	move $a1, $t2			#Load State Vector 2
	sll $a1, $a1, 16		
	xor $a1, $a1, $t3		#Load State Vector 3
	
	move $s2, $t4			#Load State Vector 4
	sll $s2, $s2, 16		
	xor $s2, $s2, $t5		#Load State Vector 5
	
	move $s3, $t6			#Load State Vector 6
	sll $s3, $s3, 16		
	xor $s3, $s3, $t7		#Load State Vector 7
	
	# load key vector
	lw $a2, 0($s1)
	sll $a2, $a2, 16
	lw $t2, 4($s1)
	xor $a2, $a2, $t2
	
	lw $a3, 8($s1)
	sll $a3, $a3, 16
	lw $t2, 12($s1)
	xor $a3, $a3, $t2
	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1,  16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	jal encryptionphase
	
	# return a0, a1, v0, v1
	move $s7, $v0
	move $t3, $a0
	
#------------ OUTPUT STAGE ---------------

	# print the result vector:
	la $a0, ciphertextresult        
      	li $v0,4
      	syscall 
      	
      	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t3
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	lw $t8, 4($s0)
	
	jal encryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	la $a0, comma         
      	li $v0,4
      	syscall

	move $a0, $t3
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	lw $t8, 8($s0)
	
	jal encryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t3
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	lw $t8, 12($s0)
	
	jal encryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t3
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	lw $t8, 16($s0)
	
	jal encryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t3
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	lw $t8, 20($s0)
	
	jal encryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t3
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	lw $t8, 24($s0)
	
	jal encryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	la $a0, comma         
      	li $v0,4
      	syscall
      	
      	move $a0, $t3
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	lw $t8, 28($s0)
	
	jal encryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
      	
#------------ OUTPUT STAGE --------------
	
#--------- PHASE III Ends Here ----------
      	 	 	 	 		 	 	 	 		 	 	 	 	
	la $a0,  finishline        
      	li $v0,4
      	syscall  
	li $v0, 10
	syscall


# inputs: a0 = iv0 || iv1, a1 = iv2 || iv3, a2 = key0 || key1, a3 = key2 || key3, v0 = key4 || key5, v1 = key6 || key7
# outputs: a0 = key0 || key1, a1 = key2 || key3, v0 = key4 || key5, v1 = key6 || key7

encryptionphase:
	subi $sp, $sp, 60
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp)
	sw $s1, 24($sp)
	sw $s2, 28($sp)
	sw $s3, 32($sp)
	sw $v0, 36($sp)
	sw $v1, 40($sp)
	sw $s4, 44($sp)
	sw $s5, 48($sp)
	sw $s6, 52($sp)
	sw $t8, 56($sp)
	
	lw $t8, 56($sp)			#Plain Text 0
	
# ------- t0 is going to be calculated -------
	
	#t4,5,6,7 reserved for keys
	srl $t0, $a0, 16		# State Vector 0
	and $t1, $a0, 65535		# State Vector 1
	srl $t2, $a1, 16		# State Vector 2
	and $t3, $a1, 65535		# State Vector 3
	
	srl $t4, $a2, 16		# Key Vector 0
	and $t5, $a2, 65535		# Key Vector 1
	srl $t6, $a3, 16		# Key Vector 2
	and $t7, $a3, 65535		# Key Vector 3
	
	xor $t4, $t4, $t0		# K0 xor R0
	xor $t5, $t5, $t1		# K1 xor R1
	xor $t6, $t6, $t2		# K2 xor R2
	xor $t7, $t7, $t3		# K3 xor R3
	add $t0, $t0, $t8
	and $t0, $t0, 65535 		# R0 + P mod 2^16
	xor $a0, $t0, $t4
	move $a1, $t5
	move $a2, $t6
	move $a3, $t7
	jal wfunctionmethod
	move $s4, $v0			#t0
	sw $s4, 44($sp)
	move $t8, $s4
	
# ------- t0 is calculated -------------------

# ------- Loading Registers Back -------------
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s2, 28($sp)
	lw $s3, 32($sp)
	lw $v0, 36($sp)
	lw $v1, 40($sp)

# ------- Loading Registers Back -------------

# ------- t1 is going to be calculated -------
	
	and $t0, $a0, 65535		# State Vector 1
	add $t0, $t0, $t8
	and $t8, $t0, 65535 		# R1 + t0 mod 2^16
	
	#t4,5,6,7 reserved for keys
	srl $t0, $s2, 16		# State Vector 4
	and $t1, $s2, 65535		# State Vector 5
	srl $t2, $s3, 16		# State Vector 6
	and $t3, $s3, 65535		# State Vector 7
	
	srl $t4, $v0, 16		# Key Vector 4
	and $t5, $v0, 65535		# Key Vector 5
	srl $t6, $v1, 16		# Key Vector 6
	and $t7, $v1, 65535		# Key Vector 7
	
	xor $t4, $t4, $t0		# K4 xor R4
	xor $t5, $t5, $t1		# K5 xor R5
	xor $t6, $t6, $t2		# K6 xor R6
	xor $t7, $t7, $t3		# K7 xor R7
	
	xor $a0, $t8, $t4
	move $a1, $t5
	move $a2, $t6
	move $a3, $t7
	jal wfunctionmethod
	move $s5, $v0			#t1
	sw $s5, 48($sp)
	move $t8, $s5
		
# ------- t1 is calculated -------------------
# ------- Loading Registers Back -------------
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s2, 28($sp)
	lw $s3, 32($sp)
	lw $v0, 36($sp)
	lw $v1, 40($sp)

# ------- Loading Registers Back -------------	

# ------- t2 is going to be calculated -------

	srl $t0, $a1, 16		# State Vector 2
	add $t0, $t0, $t8
	and $t8, $t0, 65535 		# R2 + t1 mod 2^16
	
	#t4,5,6,7 reserved for keys
	srl $t0, $s2, 16		# State Vector 4
	and $t1, $s2, 65535		# State Vector 5
	srl $t2, $s3, 16		# State Vector 6
	and $t3, $s3, 65535		# State Vector 7
	
	srl $t4, $a2, 16		# Key Vector 0
	and $t5, $a2, 65535		# Key Vector 1
	srl $t6, $a3, 16		# Key Vector 2
	and $t7, $a3, 65535		# Key Vector 3
	
	xor $t4, $t4, $t0		# K0 xor R4
	xor $t5, $t5, $t1		# K1 xor R5
	xor $t6, $t6, $t2		# K2 xor R6
	xor $t7, $t7, $t3		# K3 xor R7
	
	xor $a0, $t8, $t4
	move $a1, $t5
	move $a2, $t6
	move $a3, $t7
	jal wfunctionmethod
	move $s6, $v0			#t2
	sw $s6, 52($sp)
	move $t8, $s6
	
# ------- t2 is calculated -------------------

# ------- Loading Registers Back -------------
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s2, 28($sp)
	lw $s3, 32($sp)
	lw $v0, 36($sp)
	lw $v1, 40($sp)

# ------- Loading Registers Back -------------	

# ------- C is going to be calculated -------
	
	and $t0, $a1, 65535		# State Vector 3
	add $t0, $t0, $t8
	and $t8, $t0, 65535 		# R3 + t2 mod 2^16
	
	#t4,5,6,7 reserved for keys
	srl $t0, $a0, 16		# State Vector 0
	and $t1, $a0, 65535		# State Vector 1
	srl $t2, $a1, 16		# State Vector 2
	and $t3, $a1, 65535		# State Vector 3
	
	srl $t4, $v0, 16		# Key Vector 4
	and $t5, $v0, 65535		# Key Vector 5
	srl $t6, $v1, 16		# Key Vector 6
	and $t7, $v1, 65535		# Key Vector 7
	
	xor $t4, $t4, $t0		# K4 xor R0
	xor $t5, $t5, $t1		# K5 xor R1
	xor $t6, $t6, $t2		# K6 xor R2
	xor $t7, $t7, $t3		# K7 xor R3
	
	xor $a0, $t8, $t4
	move $a1, $t5
	move $a2, $t6
	move $a3, $t7
	jal wfunctionmethod
	move $t2, $v0			#C
	lw $a0, 4($sp)
	srl $t0, $a0, 16		# State Vector 0
	add $t8, $t2 ,$t0		# R0 + W(x)
	and $t8, $t8, 65535 		# R3 + t2 mod 2^16
	sw $t8, 56($sp)
	
# ------- C is calculated -------------------

# ------- Loading Registers Back -------------
	
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s2, 28($sp)
	lw $s3, 32($sp)
	lw $v0, 36($sp)
	lw $v1, 40($sp)
	lw $s4, 44($sp)
	lw $s5, 48($sp)
	lw $s6, 52($sp)

# ------- Loading Registers Back -------------	

	srl $t0, $a0, 16		# State Vector 0
	add $t0, $t0, $s6
	and $t0, $t0, 65535 		# R0 + t2 mod 2^16 = T0
	
	and $t1, $a0, 65535		# State Vector 1
	add $t1, $t1, $s4
	and $t1, $t1, 65535 		# R1 + t0 mod 2^16 = T1
	
	srl $t2, $a1, 16		# State Vector 2
	add $t2, $t2, $s5
	and $t2, $t2, 65535 		# R2 + t1 mod 2^16 = T2
	
	and $t3, $a1, 65535		# State Vector 3
	srl $t4, $a0, 16		# State Vector 0
	add $t3, $t3, $t4		# R3 + R0 = TEMP
	add $t3, $t3, $s6		# TEMP + t2 = TEMP
	add $t3, $t3, $s4		# TEMP + t0 = TEMP
	and $t3, $t3, 65535 		# TEMP mod 2^16 = T3
	
	srl $t4, $s2, 16		# State Vector 4
	xor $t4, $t4, $t3		# R4 xor T3
	
	and $t5, $s2, 65535		# State Vector 5
	xor $t5, $t5, $t1		# R5 xor T1
	
	srl $t6, $s3, 16		# State Vector 6
	xor $t6, $t6, $t2		# R6 xor T2
	
	and $t7, $s3, 65535		# State Vector 7
	xor $t7, $t7, $t0		# R7 xor T0
	
	sll $a0, $t0, 16		# New State Vector 0
	xor $a0, $a0, $t1		# New State Vector 1
		
	sll $a1, $t2, 16		# New State Vector 2
	xor $a1, $a1, $t3		# New State Vector 3
		
	sll $s2, $t4, 16		# New State Vector 4
	xor $s2, $s2, $t5		# New State Vector 5
		
	sll $s3, $t6, 16		# New State Vector 6
	xor $s3, $s3, $t7		# New State Vector 7
	
	lw $t8, 56($sp)			# Encrypted Message C
	move $v0, $t8
	
	lw $ra, 0($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s4, 44($sp)
	lw $s5, 48($sp)
	lw $s6, 52($sp)
	
	subi $sp, $sp, 60
	jr $ra
	

initializestatevector:
	subi $sp, $sp, 60
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	sw $s0, 20($sp)
	sw $s1, 24($sp)
	sw $s2, 28($sp)
	sw $s3, 32($sp)
	sw $v0, 36($sp)
	sw $v1, 40($sp)
	
	# t8: count of loop
	add $t8, $zero, $zero
	sw $t8, 44($sp)
	sw $t0, 48($sp)
	sw $t1, 52($sp)
	sw $t2, 56($sp)
	
	# input a0, a1 =>  iv0,..., iv3 concatenated a2, a3, v0, v1 => key0,..., key7 concatenated
	
	
	# a0 = iv0, iv1
	# = 0010 1000 0101 0010    0000 0101 1101 1111
	srl $s0, $a0, 16
	
	and $s1, $a0, 65535
	
	srl $s2, $a1, 16
	
	and $s3, $a1, 65535

	# initialize state vector: Ri = IVi mod4
	move $s4, $s0
	move $s5, $s1
	move $s6, $s2
	move $s7, $s3
	
	
	# for 3 times calculate W of state vector
	forLoop:
		lw $t8, 44($sp)
		beq $t8, 4, endLoop
		
		## calculate t0
		add $t0, $s0, $t8
		and $t0, $t0, 65535 # R0+0 mod 2^16
		
		#t4,5,6,7 reserved for keys
		srl $t4, $a2, 16
		and $t5, $a2, 65535
		srl $t6, $a3, 16
		and $t7, $a3, 65535
		
		xor $a0, $t0, $t4
		move $a1, $t5
		move $a2, $t6
		move $a3, $t7
		
		jal wfunctionmethod
		move $t0, $v0
		sw $t0, 48($sp)
		# load a regs back
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		lw $a3, 16($sp)
		lw $v0, 36($sp)
		lw $v1, 40($sp)
		
		## calculate t1
		
		add $t1, $s1, $t0
		and $t1, $t1, 65535 # R0+0 mod 2^16
		
		#t4,5,6,7 reserved for keys
		srl $t4, $v0, 16
		and $t5, $v0, 65535
		srl $t6, $v1, 16
		and $t7, $v1, 65535
		
		xor $a0, $t1, $t4
		move $a1, $t5
		move $a2, $t6
		move $a3, $t7
		
		jal wfunctionmethod
		move $t1, $v0
		sw $t1, 52($sp)
		# load a regs back
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		lw $a3, 16($sp)
		lw $v0, 36($sp)
		lw $v1, 40($sp)
		
		## calculate t2
		add $t2, $s2, $t1
		and $t2, $t2, 65535 # R0+0 mod 2^16
		
		#t4,5,6,7 reserved for keys
		srl $t4, $a2, 16
		srl $t5, $a3, 16
		srl $t6, $v0, 16
		srl $t7, $v1, 16

		
		xor $a0, $t2, $t4
		move $a1, $t5
		move $a2, $t6
		move $a3, $t7
		
		jal wfunctionmethod
		move $t2, $v0
		sw $t2, 56($sp)
		# load a regs back
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		lw $a3, 16($sp)
		lw $v0, 36($sp)
		lw $v1, 40($sp)

		## calculate t3
		
		add $t3, $s3, $t2
		and $t3, $t3, 65535 # R0+0 mod 2^16
		
		#t4,5,6,7 reserved for keys
		and $t4, $a2, 65535
		and $t5, $a3, 65535
		and $t6, $v0, 65535
		and $t7, $v1, 65535
		
		xor $a0, $t3, $t4
		move $a1, $t5
		move $a2, $t6
		move $a3, $t7
		
		jal wfunctionmethod
		move $t3, $v0
	
		# load a regs back
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		lw $a3, 16($sp)
		lw $v0, 36($sp)
		lw $v1, 40($sp)
		lw $t0, 48($sp)
		lw $t1, 52($sp)
		lw $t2, 56($sp)
		
		# second part of for loop
		
		add $s0, $s0, $t3
		and $s0, $s0, 65535 # R0+0 mod 2^16
		rol $s0, $s0, 3
		# 0000 0000 0000 0000 1010 0100 0000 1111  -init
		# 0000 0000 0000 0101 0010 0000 0111 1000  -after left shift 
		# 0000 0000 0000 0000 1010 0100 0000 1111  -expected for circular shift
		# 0000 0000 0000 0000 0000 0000 0000 0101   -t3
		srl $t3, $s0, 16
		xor $s0, $s0, $t3
		and $s0, $s0, 65535 # R0+0 mod 2^16 
		
		
		add $s1, $s1, $t0
		and $s1, $s1, 65535 # R0+0 mod 2^16
		ror	 $s1, $s1, 5
		# 0000 0000 0000 0000 1010 0100 0000 1111  -init
		# 1110 0000 0000 0000 0001 0100 1000 0001  -after right shift 
		# 0000 0000 0000 0000 1111 0100 1000 0001  -expected for circular shift
		# 0000 0000 0000 0000 1110 0000 0000 0101   -t0
		srl $t0, $s1, 16
		xor $s1, $s1, $t0
		and $s1, $s1, 65535 # R0+0 mod 2^16
		
		add $s2, $s2, $t1
		and $s2, $s2, 65535 # R0+0 mod 2^16
		rol $s2, $s2, 8
		# fix 32 bit shift
		srl $t1, $s2, 16
		xor $s2, $s2, $t1
		and $s2, $s2, 65535 # R0+0 mod 2^16
		
		add $s3, $s3, $t2
		and $s3, $s3, 65535 # R0+0 mod 2^16
		rol $s3, $s3, 6
		# fix 32 bit shift
		srl $t2, $s3, 16
		xor $s3, $s3, $t2
		and $s3, $s3, 65535 # R0+0 mod 2^16
		
		xor $s4, $s4, $s3
		xor $s5, $s5, $s1
		xor $s6, $s6, $s2
		xor $s7, $s7, $s0
		
		lw $t8, 44($sp)
		addi $t8, $t8, 1
		sw $t8, 44($sp)
		j forLoop
	endLoop:
		# a0, a1, v0, v1 = R01234567
		sll $a0, $s0, 16
		xor $a0, $a0, $s1
		
		sll $a1, $s2, 16
		xor $a1, $a1, $s3
		
		sll $v0, $s4, 16
		xor $v0, $v0, $s5
		
		sll $v1, $s6, 16
		xor $v1, $v1, $s7
		
		lw $ra, 0($sp)
		lw $s0, 20($sp)
		lw $s1, 24($sp)
		lw $s2, 28($sp)
		lw $s3, 32($sp)
		
		addi $sp, $sp, 60
		jr $ra
		
wfunctionmethod:
	subi $sp, $sp, 20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	jal singletablemethod
	move $a0, $v0
        
        jal linearfunction
        move $a0, $v0
        
        xor $a0, $a0, $a1
        
        jal singletablemethod
	move $a0, $v0
        
        jal linearfunction
        move $a0, $v0
        
        xor $a0, $a0, $a2
        
        jal singletablemethod
	move $a0, $v0
        
        jal linearfunction
        move $a0, $v0
        
        xor $a0, $a0, $a3
        
        jal singletablemethod
	move $a0, $v0
        
        jal linearfunction
        move $a0, $v0
        
        add $v0, $zero, $v0
	
	lw $a3, 16($sp)		#restore register $a3
	lw $a2, 12($sp)		#restore register $a2
	lw $a1, 8($sp)		#restore register $a1
  	lw $a0, 4($sp)		#restore register $a0
  	lw $ra, 0($sp)		#restore the return address
  	addi $sp, $sp, 20	#pop five items
  	jr $ra			#return to the caller
      		
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


	# now get the sbox results (lh used since input will be 16 bits
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