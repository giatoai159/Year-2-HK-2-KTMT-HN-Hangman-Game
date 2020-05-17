.data
	SoChanRandom: .word 0
	MaxRandom: .word 0
	ChuCaiDaDoan: .word 0
	tempString: .word 0
.text
	.globl main
main:

	#Test ham random so chan
#	li $v0,5
#	syscall
#	sw $v0,MaxRandom
#	lw $a1,MaxRandom
#	jal _randomSoChan
#	sw $v0,SoChanRandom
#	li $v0,1
#	lw $a0,SoChanRandom
#	syscall
	#Test ham random so chan - End
	li $v0,8
	la $a0,ChuCaiDaDoan
	la $a1,26
	syscall
	lw $a0,ChuCaiDaDoan
	li $a1,65
	li $a2,77
	jal _InChuCai
	# ket thuc chuong trinh
	li $v0,10
	syscall
#----------------------------------------------------------------------------------------------------------------------------------------#
_randomSoChan:
	# Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	# Than thu tuc
	li $t0,2
	div $a1,$t0 # MAX % 2
	mfhi $t1
	beq $t1,1,_randomSoChan.max #if(max % 2 = 1) max--;
	j _randomSoChan.thoatMax
_randomSoChan.max:
	addi $a1,$a1,-1
_randomSoChan.thoatMax:
	addi $a1,$a1,2 # Tang upper bound cua max
	li $v0,42
	syscall

	move $s0,$a0 # Random number -> s0
	div $s0,$t0 # s0 / 2 lay thuong
	mflo $s0
	mult $s0,$t0 # s0 * 2 lay tich
	mflo $s0
	move $v0,$s0
	#Cuoi thu tuc
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	# Xoa Stack
	addi $sp,$sp,32
	#Quay ve
	jr $ra

#----------------------------------------------------------------------------------------------------------------------------------------# WIP
_InChuCai:
	#Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)

	#Than thu tuc
_InChuCai.Loop1:
	bgt $a1,$a2,_InChuCai.ExitLoop1
	
	addi $a1,$a1,1
	j _InChuCai.Loop1
_InChuCai.ExitLoop1: