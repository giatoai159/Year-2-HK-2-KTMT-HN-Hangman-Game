.data
#--------------------------------------------------------------------TOAI---------------------------------------------------------------------#
	SoChanRandom: .word 0
	MaxRandom: .word 0
	ChuCaiDaDoan: .word 0
	tempString: .word 0
	test: .asciiz "   "
#--------------------------------------------------------------------TOAI---------------------------------------------------------------------#
#--------------------------------------------------------------------VINH---------------------------------------------------------------------#
	InHangMan1Dong1: .asciiz "__________\n"
	InHangMan1Dong2: .asciiz "|/       |\n"
	InHangMan1Dong3: .asciiz "|         \n"
	InHangMan2Dong3: .asciiz "|        O\n"
	InHangMan3Dong4: .asciiz "|       /\n"
	InHangMan4Dong4: .asciiz "|       /|\n"
	InHangMan5Dong4: .asciiz "|       /|\\\n"
	InHangMan7Dong5: .asciiz "|       / \\\n"
#--------------------------------------------------------------------VINH---------------------------------------------------------------------#
#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#

#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#
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

#--------------------------------------------------------TOAI----------------------------------------------------------------------#

#----------------------------------------------------------------------------------------------------------------------------------------#
#int randomSoChan( int max)
#{
#	if (max % 2 == 1)
#		max--;
#	int random = (rand() % (max + 1) / 2;
#	return random * 2;
#}
# Ham random so chan INPUT: MAX la $a1, OUTPUT: so ngau nhien tu 0~MAX tai $v0
_randomSoChan:
	# Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $a1,16($sp)
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
	lw $a1,16($sp)
	# Xoa Stack
	addi $sp,$sp,32
	#Quay ve
	jr $ra

#----------------------------------------------------------------------------------------------------------------------------------------# WIP
#void InChuCai(string chucaidoan, char tu, char den)
#{
#	string s;
#	for (char i = tu; i <= den; i++)
#	{
#		if (chucaidoan.find(i)==-1)
#		{
#			s += i;
#			s += "  ";
#		}
#		else
#			s += "   ";
#	}
#}
_InChuCai:
	#Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)

	#Than thu tuc
	# Tinh chieu dai cua string
	la $t0,ChuCaiDaDoan
	li $t1,0
_InChuCai.strLength:
	lb $t2,($t0)
	bne $t2,'\n',_InChuCai.strLengthTangDem
	j _InChuCai.strLengthEnd
_InChuCai.strLengthTangDem:
	addi $t1,$t1,1
	addi $t0,$t0,1
	j _InChuCai.strLength
_InChuCai.strLengthEnd:
	addi $t0,$t0,-1
	# output t1 la strLength
	la $t0,ChuCaiDaDoan # restore t0
	
_InChuCai.Loop1:
	bgt $a1,$a2,_InChuCai.ExitLoop1 # Chay tu from -> to tu du lieu truyen vao

#### WIP - Eu biet lam
	li $t2,0 # dem = 0
_InChuCai.Loop2:
	bge $t2,$t1,_InChuCai.Loop2.Exit
	lb $t3,($t0)
	bne $t3,$a1,_InChuCai.Loop3
	
_InChuCai.Loop2.Cont:
	addi $t2,$t2,1
	addi $t0,$t0,1
	j _InChuCai.Loop2
_InChuCai.Loop3:
	
	j _InChuCai.Loop2.Cont
_InChuCai.Loop2.Exit:
	
#### WIP
	addi $a1,$a1,1
	j _InChuCai.Loop1
_InChuCai.ExitLoop1:

#--------------------------------------------------------------------TOAI---------------------------------------------------------------------#

#--------------------------------------------------------------------VINH---------------------------------------------------------------------#
_InHangMan: #Ham nhan vao 1 so #$a0 tu 1->7 va in ra hinh Hangman treo co tuong ung
#Dau thu tuc:
	addi $sp,$sp,-32
	sw $ra,($sp)
	beq $a0,7,InHangMan.7
	beq $a0,6,InHangMan.6
	beq $a0,5,InHangMan.5
	beq $a0,4,InHangMan.4
	beq $a0,3,InHangMan.3
	beq $a0,2,InHangMan.2
	beq $a0,1,InHangMan.1

#Cuoi thu tuc:
	lw $ra,($sp)
	addi $sp,$sp,32
	jr $ra
#Ket thuc:
_InHangMang.KetThuc:
	li $v0,10
	syscall
InHangMan.1:
	la $a0,InHangMan1Dong1
	li $v0,4
	syscall
	la $a0,InHangMan1Dong2
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	j _InHangMang.KetThuc
InHangMan.2:
	la $a0,InHangMan1Dong1
	li $v0,4
	syscall
	la $a0,InHangMan1Dong2
	li $v0,4
	syscall
	la $a0,InHangMan2Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	j _InHangMang.KetThuc
InHangMan.3:
	la $a0,InHangMan1Dong1
	li $v0,4
	syscall
	la $a0,InHangMan1Dong2
	li $v0,4
	syscall
	la $a0,InHangMan2Dong3
	li $v0,4
	syscall
	la $a0,InHangMan3Dong4
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	j _InHangMang.KetThuc
InHangMan.4:
	la $a0,InHangMan1Dong1
	li $v0,4
	syscall
	la $a0,InHangMan1Dong2
	li $v0,4
	syscall
	la $a0,InHangMan2Dong3
	li $v0,4
	syscall
	la $a0,InHangMan4Dong4
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	j _InHangMang.KetThuc
InHangMan.5:
	la $a0,InHangMan1Dong1
	li $v0,4
	syscall
	la $a0,InHangMan1Dong2
	li $v0,4
	syscall
	la $a0,InHangMan2Dong3
	li $v0,4
	syscall
	la $a0,InHangMan5Dong4
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	j _InHangMang.KetThuc
InHangMan.6:
	la $a0,InHangMan1Dong1
	li $v0,4
	syscall
	la $a0,InHangMan1Dong2
	li $v0,4
	syscall
	la $a0,InHangMan2Dong3
	li $v0,4
	syscall
	la $a0,InHangMan5Dong4
	li $v0,4
	syscall
	la $a0,InHangMan3Dong4
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	j _InHangMang.KetThuc
InHangMan.7:
	la $a0,InHangMan1Dong1
	li $v0,4
	syscall
	la $a0,InHangMan1Dong2
	li $v0,4
	syscall
	la $a0,InHangMan2Dong3
	li $v0,4
	syscall
	la $a0,InHangMan5Dong4
	li $v0,4
	syscall
	la $a0,InHangMan7Dong5
	li $v0,4
	syscall
	la $a0,InHangMan1Dong3
	li $v0,4
	syscall
	j _InHangMang.KetThuc
#--------------------------------------------------------------------VINH---------------------------------------------------------------------#

#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#

#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#
