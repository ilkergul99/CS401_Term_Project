.data
            #    0    1    2    3    4    5    6    7    8    9    a    b    c    d     e   f
sboxzero: .word 0xf, 0x4, 0x5, 0x8, 0x9, 0x7, 0x2, 0x1, 0xa, 0x3, 0x0, 0xe, 0x6, 0xc, 0xd, 0xb
sboxone: .word 0x4, 0xa, 0x1, 0x6, 0x8, 0xf, 0x7, 0xc, 0x3, 0x0, 0xe, 0xd, 0x5, 0x9, 0xb, 0x2
sboxtwo: .word 0x2, 0xf, 0xc, 0x1, 0x5, 0x6, 0xa, 0xd, 0xe, 0x8, 0x3, 0x4, 0x0, 0xb, 0x9, 0x7
sboxthree: .word 0x7, 0xc, 0xe, 0x9, 0x2, 0x1, 0x5, 0xf, 0xb, 0x6, 0xd, 0x0, 0x4, 0x8, 0xa, 0x3
sinversezero: .word 0xa, 0x7, 0x6, 0x9, 0x1, 0x2, 0xc, 0x5, 0x3, 0x4, 0x8, 0xf, 0xd, 0xe, 0xb, 0x0
sinverseone: .word 0x9, 0x2, 0xf, 0x8, 0x0, 0xc, 0x3, 0x6, 0x4, 0xd, 0x1, 0xe, 0x7, 0xb, 0xa, 0x5
sinversetwo: .word 0xc, 0x3, 0x0, 0xa, 0xb, 0x4, 0x5, 0xf, 0x9, 0xe, 0x6, 0xd, 0x2, 0x7, 0x8, 0x1
sinversethree: .word 0xb, 0x5, 0x4, 0xf, 0xc, 0x6, 0x9, 0x0, 0xd, 0x3, 0xe, 0x8, 0x1, 0xa, 0x2, 0x7
fulltable: .word 0xf427, 0x4afc, 0x51ce, 0x8619, 0x9852, 0x7f61, 0x27a5, 0x1cdf, 0xa3eb, 0x3086, 0x0e3d, 0xed40, 0x6504, 0xc9b8, 0xdb9a, 0xb273
fulltableinverse: .word 0xa9cb, 0x7235, 0x6f04, 0x98af, 0x10bc, 0x2c46, 0xc359, 0x56f0, 0x349d, 0x4de3, 0x816e, 0xfed8, 0xd721, 0xeb7a, 0xba82, 0x0517
testVectorIV: .word 0xb606, 0x8c2, 0x7bb2, 0x5fe0
testVectorKey: .word 0xe3ad, 0x5c8c, 0xd785, 0xf247, 0xd52f, 0x32c8, 0x9158, 0xcd01
testPlain: .word 0x484d, 0xba44, 0xae78, 0x8e7, 0x2655, 0x2e52, 0x7de1, 0xdd24
testCipher: .word 56002, 995, 1473, 40946, 64386, 55302, 31701, 61781


randNumber: .asciiz "Selected number's hexadecimal version is: "
randNumber2: .asciiz "Numbers' hexadecimal versions are as follows: "
dashline: .asciiz  "\n - - - - - - - - - - - - - - - - -"
welcoming: .asciiz  "\nWelcome to the CS401 Project Phase IV"
preference: .asciiz  "\Select one of the options below for table method\nFor single table method please enter 0\nFor multiple table method please enter 1\nYour preference is: "
Sboxresult: .asciiz "\nThe result of S(x) is  "
Fboxresult: .asciiz "\nThe result of F(x) is  "
Finverseboxresult: .asciiz "\nThe result of F(x)-1 is  "
Linearresult: .asciiz "\nThe result of L(x) is  "
finishline: .asciiz  "\nPhase II program is completed"
finishline2: .asciiz  "\nPhase IV program is completed"
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
testingEncDec: .asciiz  "\nTesting encryption and decryption with test vectors: "

wboxresult: .asciiz "\nThe result of W(X, A, B, C, D) is  "
statevectorresult: .asciiz "\nThe state vector is initialized to:   "
ciphertextresult: .asciiz "\nPlain Text is encrypted to:   "
plaintextresult: .asciiz "\nCipher Text is decrypted to:   "
phase4step4getinput: .asciiz "\nEnter a plaintext to encrypt then decrypt: "
phase4step4writeinput: .asciiz "\nPlaintext in hexadecimal representation: "
phase4step4writeencryptedtext: .asciiz "\nEncrypted text in hexadecimal representation: "
phase4step4writedecryptedtext: .asciiz "\nDecrypted text in hexadecimal representation: "
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
	
	jal linearinversefunction
	move $a0, $v0
        
        jal singletableinversemethod
        move $t0, $v0
	la $a0,  Finverseboxresult			# the result of F(x)-1 is
      	li $v0,4
      	syscall
      	
      	move $a0, $t0
      	li $v0, 34 				# print result of F(x)-1
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
	
	srl $t0, $a0, 16
	and $t1, $a0, 65535
	srl $t2, $a1, 16
	and $t3, $a1, 65535
	srl $t4, $v0, 16
	and $t5, $v0, 65535
	srl $t6, $v1, 16
	and $t7, $v1, 65535
	
	sw $t0, 32($sp)
	sw $t1, 36($sp)
	sw $t2, 40($sp)
	sw $t3, 44($sp)
	sw $t4, 48($sp)
	sw $t5, 52($sp)
	sw $t6, 56($sp)
	sw $t7, 60($sp)
	
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
      	
	la $a0, finishline        
      	li $v0,4
      	syscall 
#--------- PHASE III Starts Here --------
	
	la $a0, testingEncDec        
      	li $v0,4
      	syscall 
	
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

#--------- PHASE IV Starts Here ---------

	la $s0, testCipher
	lw $t8, 0($s0)	
	la $s1, testVectorKey

	addi $t0, $zero, 0xa252
	addi $t1, $zero, 0x62e4
	addi $t2, $zero, 0xea64
	addi $t3, $zero, 0xefa1
	addi $t4, $zero, 0x2c0a 
	addi $t5, $zero, 0xe073 
	addi $t6, $zero, 0xa75d 
	addi $t7, $zero, 0x5fb5
	
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
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	jal decryptionphase
	
	# return a0, a1, v0, v1
	move $s7, $v0
	move $t3, $a0
	
#------------ OUTPUT STAGE ---------------

	# print the result vector:
	la $a0, plaintextresult        
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
	
	jal decryptionphase
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
	
	jal decryptionphase
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
	
	jal decryptionphase
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
	
	jal decryptionphase
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
	
	jal decryptionphase
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
	
	jal decryptionphase
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
	
	jal decryptionphase
	move $s7, $v0
	move $t3, $a0
	move $a0, $s7
        li $v0,34
      	syscall 
      	
#------------ Step 2 of Phase 4 start --------------      	
      
      		# input a number
	la $a0,  phase4step4getinput        
      	li $v0, 4
      	syscall  
      	
      	li $v0, 5		# number input
	syscall
	move $t8, $v0	
	
	la $a0,  phase4step4writeinput        
      	li $v0, 4
      	syscall  
      	
	
	move $a0, $t8
      	li $v0, 34
      	syscall
	
	addi $t0, $zero, 0xa252
	addi $t1, $zero, 0x62e4
	addi $t2, $zero, 0xea64
	addi $t3, $zero, 0xefa1
	addi $t4, $zero, 0x2c0a 
	addi $t5, $zero, 0xe073 
	addi $t6, $zero, 0xa75d 
	addi $t7, $zero, 0x5fb5
	
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
	
	la $s1, testVectorKey
      	
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
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	jal encryptionphase
	
	move $s7, $v0
	
	la $a0,  phase4step4writeencryptedtext        
      	li $v0, 4
      	syscall
	
	move $a0, $s7
      	li $v0,34
      	syscall 
      	
      	move $t8, $s7
      	
	addi $t0, $zero, 0xa252
	addi $t1, $zero, 0x62e4
	addi $t2, $zero, 0xea64
	addi $t3, $zero, 0xefa1
	addi $t4, $zero, 0x2c0a 
	addi $t5, $zero, 0xe073 
	addi $t6, $zero, 0xa75d 
	addi $t7, $zero, 0x5fb5
	
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
		
      	
	lw $v0, 16($s1)
	sll $v0, $v0, 16
	lw $t2, 20($s1)
	xor $v0, $v0, $t2
	
	lw $v1, 24($s1)
	sll $v1, $v1, 16
	lw $t2, 28($s1)
	xor $v1, $v1, $t2
	
	#lw $t8, 24($s0)
	
	jal decryptionphase
	move $s7, $v0
	la $a0,  phase4step4writedecryptedtext        
      	li $v0, 4
      	syscall
	move $a0, $s7
      li $v0,34
      	syscall 
      	
#------------ OUTPUT STAGE --------------

#--------- PHASE IV Ends Here -----------
      	 		 	 	 	 		 	 	 	 	
	la $a0,  finishline2        
      	li $v0,4
      	syscall  
	li $v0, 10
	syscall


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
	

decryptionphase:
	subi $sp, $sp, 80
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
	sw $t3, 60($sp)
	sw $t4, 64($sp)
	sw $t2, 68($sp)
	sw $t1, 72($sp)
	sw $t0, 76($sp)
	lw $t8, 56($sp)			#Plain Text 0
	
# ------- t2 is going to be calculated -------
	
	#t4,5,6,7 reserved for keys
	srl $t0, $a0, 16		# State Vector 0
	and $t1, $a0, 65535		# State Vector 1
	srl $t2, $a1, 16		# State Vector 2
	and $t3, $a1, 65535		# State Vector 3
	

	srl $t4, $v0, 16		# Key Vector 4
	xor $t4, $t4, $t0 		# k4 (+) r0
	
	
	and $t5, $v0, 65535 		# Key Vector 5
	xor $t5, $t5, $t1		# k5 (+) r1

	srl $t6, $v1, 16		# Key Vector 6
	xor $t6, $t6, $t2		# k6 (+) r2

	and $t7, $v1, 65535	# Key Vector 7
	xor $t7, $t7, $t3		# k7 (+) r3

	
	sub $t0, $t8, $t0
	and $t0, $t0, 65535 		# C - R0 mod 2^16
	move $a0, $t0			#X
	move $a1, $t7			#t7 = d
	move $a2, $t6			#t6 = c
	move $a3, $t5			#t5 = b
	
	sw $t3, 60($sp)
	sw $t4, 64($sp)
	jal wfunctioninversemethod
	lw $t3, 60($sp)
	lw $t4, 64($sp)
	move $s6, $v0			#t2
	xor $s6, $s6, $t4
	sub $s6, $s6, $t3
	and $s6, $s6, 65535
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

# ------- t1 is going to be calculated -------
	
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
	
	move $a0, $t8			#X
	move $a1, $t7			#t7 = d
	move $a2, $t6			#t6 = c
	move $a3, $t5			#t5 = b
	
	sw $t2, 68($sp)
	sw $t4, 64($sp)
	jal wfunctioninversemethod
	lw $t2, 68($sp)
	lw $t4, 64($sp)
	move $s5, $v0			#t1
	xor $s5, $s5, $t4		# xor A
	lw $a1, 8($sp)
	srl $t2, $a1, 16		# State Vector 2
	sub $s5, $s5, $t2
	and $s5, $s5, 65535
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

# ------- t0 is going to be calculated -------

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
	
	move $a0, $t8			#X
	move $a1, $t7			#t7 = d
	move $a2, $t6			#t6 = c
	move $a3, $t5			#t5 = b
	sw $t1, 72($sp)
	sw $t4, 64($sp)
	jal wfunctioninversemethod
	lw $t1, 72($sp)
	lw $t4, 64($sp)
	move $s4, $v0			#t0
	xor $s4, $s4, $t4		# xor A
	lw $a0, 4($sp)
	and $t1, $a0, 65535		# State Vector 1
	sub $s4, $s4, $t1		# State Vector 1
	and $s4, $s4, 65535
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

# ------- P is going to be calculated -------
	
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
	
	move $a0, $t8			#X
	move $a1, $t7			#t7 = d
	move $a2, $t6			#t6 = c
	move $a3, $t5			#t5 = b
	sw $t0, 76($sp)
	sw $t4, 64($sp)
	jal wfunctioninversemethod
	lw $t0, 76($sp)
	lw $t4, 64($sp)
	move $t2, $v0			#C
	xor $t2, $t2, $t4		# xor A
	lw $a0, 4($sp)
	srl $t0, $a0, 16		# State Vector 0
	sub $t8, $t2 ,$t0		# w-1(X) - R0
	and $t8, $t8, 65535 		# w-1(X) - R0 mod 2^16
	sw $t8, 56($sp)
	
# ------- P is calculated -------------------

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
	
	lw $t8, 56($sp)			# Decrypted Message P
	move $v0, $t8
	
	lw $ra, 0($sp)
	lw $a2, 12($sp)
	lw $a3, 16($sp)
	lw $s0, 20($sp)
	lw $s1, 24($sp)
	lw $s4, 44($sp)
	lw $s5, 48($sp)
	lw $s6, 52($sp)
	
	subi $sp, $sp, 80
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
 
 # bu fonksiyon icin a b c d order degismeli input olarak verirken	 	
 wfunctioninversemethod:
	subi $sp, $sp, 20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	sw $a2, 12($sp)
	sw $a3, 16($sp)
	
	jal linearinversefunction
	move $a0, $v0
        
        jal singletableinversemethod
        move $a0, $v0
        
        xor $a0, $a0, $a1
        
        jal linearinversefunction
	move $a0, $v0
        
        jal singletableinversemethod
        move $a0, $v0
        
        xor $a0, $a0, $a2
        
        jal linearinversefunction
	move $a0, $v0
        
        jal singletableinversemethod
        move $a0, $v0
        
        xor $a0, $a0, $a3
        
        jal linearinversefunction
	move $a0, $v0
        
        jal singletableinversemethod
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
  	
 multitableinversemethod:
	subi $sp, $sp, 12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s2, 8($sp)

	la $s0, sinversezero # s4 => base address of sinverse0
	la $s1, sinverseone # s4 => base address of sinverse1
	la $s2, sinversetwo # s4 => base address of sinverse2
	la $s3, sinversethree # s4 => base address of sinverse3

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
  	
 singletableinversemethod:
 	subi $sp, $sp, 12
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s2, 8($sp)
	
	la $s0, fulltableinverse
	#addi $s1, $s0, 64  # s4 => base address of sinverse1
	#addi $s2, $s0, 128 # s4 => base address of sinverse2
	#addi $s3, $s0, 192 # s4 => base address of sinverse3
	
	
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
 
 
 # input a0=X => output v0=L'(X)
  linearinversefunction:
 	subi $sp, $sp, 20
 	sw $a0, 0($sp)
 	sw $s0, 4($sp)
 	sw $s1, 8($sp)
 	sw $s2, 12($sp)
 	sw $ra, 16($sp)
 	#jal linearfunction
 	move $s0, $a0 # s0 = L(X)
 	
 	rol $s1, $s0, 10 # left circular shift
 	srl $t1, $s1, 16
 	and $s1, $s1, 64512
 	xor $s1, $s1, $t1 # s1 = L(X) <<< 10
 	
 	ror $s2, $s0, 10 # right circular shift
 	srl $t1, $s2, 16
 	and $s2, $s2, 63
 	xor $s2, $s2, $t1 # s2 = L(X) >>> 10
 	
 	xor $t0, $s0, $s1
 	xor $s0, $t0, $s2 # s0 = Y
 	
 	
 	rol $s1, $s0, 4 # left circular shift
 	srl $t1, $s1, 16
 	and $s1, $s1, 65520
 	xor $s1, $s1, $t1 # s1 = y <<< 4
 	
 	ror $s2, $s0, 4 # right circular shift
 	srl $t1, $s2, 16
 	and $s2, $s2, 4095
 	xor $s2, $s2, $t1 # s2 = y <<< 4
 	
 	xor $t0, $s0, $s1
 	xor $v0, $t0, $s2 # v0 = L(X)-1
 	
 	lw $a0, 0($sp)
 	lw $s0, 4($sp)
 	lw $s1, 8($sp)
 	lw $s2, 12($sp)
 	lw $ra, 16($sp)
 	addi $sp, $sp, 20
 	
 	jr $ra
