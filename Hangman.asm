.data
	SoChanRandom: .word 0
	MaxRandom: .word 0
.text
	.globl main
main:
	li $v0,5
	syscall
	sw $v0,MaxRandom
	lw $a1,MaxRandom
	jal _randomSoChan
	sw $v0,SoChanRandom
	li $v0,1
	lw $a0,SoChanRandom
	syscall
	# ket thuc chuong trinh
	li $v0,10
	syscall
_randomSoChan:
	# Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
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
	# Xoa Stack
	addi $sp,$sp,32
	#Quay ve
	jr $ra