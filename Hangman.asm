<<<<<<< HEAD
.data
#--------------------------------------------------------------------TOAI---------------------------------------------------------------------#
	SoChanRandom: .word 0
	MaxRandom: .word 0
	ChuCaiDaDoan: .word 0
	tempString: .word 0
	test: .asciiz "   "
#--------------------------------------------------------------------TOAI---------------------------------------------------------------------#
#--------------------------------------------------------------------VINH---------------------------------------------------------------------#
	InHangMan1Dong1: .asciiz "__________"
	InHangMan1Dong2: .asciiz "|/       |"
	InHangMan1Dong3: .asciiz "|         "
	InHangMan2Dong3: .asciiz "|        O"
	InHangMan3Dong4: .asciiz "|       /"
	InHangMan4Dong4: .asciiz "|       /|"
	InHangMan5Dong4: .asciiz "|       /|\\"
	InHangMan7Dong5: .asciiz "|       / \\"
	MotDongKhoangTrong: .asciiz "\n|                                                 |\n"
	vien: .asciiz "\n+------------------------------------------------+\n"
	res: .asciiz ""
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
_InHangMan:
#Dau thu tuc:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $a1,4($sp)
	sw $a2,8($sp)
	#Truyen vao hai tham so mac dinh de khong in vien tren va vien duoi cho cac Hangman
	li $a1,0
	li $a2,0
	
	beq $a0,7,InHangMan.7
	beq $a0,6,InHangMan.6
	beq $a0,5,InHangMan.5
	beq $a0,4,InHangMan.4
	beq $a0,3,InHangMan.3
	beq $a0,2,InHangMan.2
	beq $a0,1,InHangMan.1
	beqz $a0,InMotDongKhoangTrong

#Cuoi thu tuc:
	lw $ra,($sp)
	lw $a1,4($sp)
	lw $a2,8($sp)
	addi $sp,$sp,32
#Ket thuc:
_InHangMan.KetThuc:
	li $v0,10
	syscall
InHangMan.1:
	la $a0,InHangMan1Dong1
	jal _InChu
	la $a0,InHangMan1Dong2
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	j _InHangMan.KetThuc
InHangMan.2:
	la $a0,InHangMan1Dong1
	jal _InChu
	la $a0,InHangMan1Dong2
	jal _InChu
	la $a0,InHangMan2Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	j _InHangMan.KetThuc
InHangMan.3:
	la $a0,InHangMan1Dong1
	jal _InChu
	la $a0,InHangMan1Dong2
	jal _InChu
	la $a0,InHangMan2Dong3
	jal _InChu
	la $a0,InHangMan3Dong4
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	j _InHangMan.KetThuc
InHangMan.4:
	la $a0,InHangMan1Dong1
	jal _InChu
	la $a0,InHangMan1Dong2
	jal _InChu
	la $a0,InHangMan2Dong3
	jal _InChu
	la $a0,InHangMan4Dong4
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	j _InHangMan.KetThuc
InHangMan.5:
	la $a0,InHangMan1Dong1
	jal _InChu
	la $a0,InHangMan1Dong2
	jal _InChu
	la $a0,InHangMan2Dong3
	jal _InChu
	la $a0,InHangMan5Dong4
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	j _InHangMan.KetThuc
InHangMan.6:
	la $a0,InHangMan1Dong1
	jal _InChu
	la $a0,InHangMan1Dong2
	jal _InChu
	la $a0,InHangMan2Dong3
	jal _InChu
	la $a0,InHangMan5Dong4
	jal _InChu
	la $a0,InHangMan3Dong4
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	j _InHangMan.KetThuc
InHangMan.7:
	la $a0,InHangMan1Dong1
	jal _InChu
	la $a0,InHangMan1Dong2
	jal _InChu
	la $a0,InHangMan2Dong3
	jal _InChu
	la $a0,InHangMan5Dong4
	jal _InChu
	la $a0,InHangMan7Dong5
	jal _InChu
	la $a0,InHangMan1Dong3
	jal _InChu
	j _InHangMan.KetThuc
InMotDongKhoangTrong:
	la $a0,MotDongKhoangTrong
	li $v0,4
	syscall
	j _InHangMan.KetThuc
#----------------------------------------------------------------------
_InChuCaiConLai: #$a0: string chucaidadoan
#Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
#Khoi tao
	move $a3,$a0
#Than thu tuc
	li $a1,1
	li $a2,1
	la $a0,tb1
	jal _InChu
	move $a0,$a3
	li $a1,'A'
	li $a2,'M'
	jal _InChuCai
	move $a0,$a3
	li $a1,'N'
	li $a2,'Z'
	jal _InChuCai
#Cuoi thu tuc
	lw $ra,($sp)
	addi $sp,$sp,32
#Ket thuc
	jr $ra
#----------------------------------------------------------------------
_InChuCai: #void InChuCai(string chucaidoan, char tu, char den)
#$a0: chucaidoan, $a1: tu, $a2: den
#Dau thu tuc:
	addi $sp,$sp,-36
	sw $ra,($sp)
	sw $s7,4($sp)
	sw $s0,8($sp)
	sw $s1,12($sp)
	sw $s2,16($sp)
	sw $t0,20($sp)
	sw $t2,24($sp)
	sw $t1,28($sp)
	sw $s3,32($sp)
#Khoi tao
	move $s0,$a0 #string ban dau
	move $s3,$a0 #string ban dau
	move $s1,$a1
	move $s2,$a2
	move $t0,$a1 #bien i
	la $s7,res #bien luu tru ket qua de in ra
#Than thu tuc
_InChuCai.Lap:
	move $a0,$t0
	la $a1,($s3)
	jal _Tim
	move $t2,$v0

	bne $t2,-1,InChuCai.CongKyTu2
	beq $t2,-1,InChuCai.CongKyTu1

	InChuCai.CongKyTu.TiepTuc:

	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0

	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	
	addi $t0,$t0,1
	addi $s0,$s0,1
	sub $t1,$s2,$t0 #$t1=$s2-$t0
	bgez $t1,_InChuCai.Lap #Neu $t1<=0 thi lap

	#Truyen tham so cho ham _InChu
	la $a0,($s7)
	li $a1,0
	li $a2,0
	jal _InChu
	
	#Xoa bo nho dem cua $s7 va tra ve vi tri con tro bat dau cua $s7
	li $t2,0
_s7.Lap:
	lb $t1,($s7)
	sb $t2,($s7)
	addi $s7,$s7,1
	addi $t0,$t0,1
	bne $t1,'\0',_s7.Lap
	sub $s7,$s7,$t0
	#addi $s7,$s7,-1
#Cuoi thu tuc
	lw $ra,($sp)
	lw $s7,4($sp)
	lw $s0,8($sp)
	lw $s1,12($sp)
	lw $s2,16($sp)
	lw $t0,20($sp)
	lw $t2,24($sp)
	lw $t1,28($sp)
	lw $s3,32($sp)
	addi $sp,$sp,36
#Ket thuc
	jr $ra
	
#----------------------------------------------------------------------
_Tim: #Ham nhan vao 1 chuoi va 1 ky tu, tra ve vi tri dau tien cua ky tu trong chuoi do duoc tim thay, neu khong tim thay return -1
#$a0: ky tu, $a1: chuoi, $v0: vi tri
#Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	
#Khai bao
	li $v0,-1 #Ket qua tra ve
	li $t0,0 #Bien lap i
#Than thu tuc
_Tim.Lap:
	lb $t1,($a1)
	#Tang dem
	addi $t0,$t0,1
	addi $a1,$a1,1
	beq $t1,$a0,_Tim.Lap.TraVe
	bne $t1,'\0',_Tim.Lap
	_Tim.Lap.TraVe.TiepTuc:
#Cuoi thu tuc
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,32
#Ket thuc
	jr $ra
_Tim.Lap.TraVe:
	move $v0,$t0
	addi $v0,$v0,-1
	j _Tim.Lap.TraVe.TiepTuc
#----------------------------------------------------------------------
InChuCai.CongKyTu1:
	move $a0,$t0
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc
InChuCai.CongKyTu2:
	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc
#----------------------------------------------------------------------
_CongKyTu: #$a0: ky tu can cong, $a1: chuoi ban dau truyen vao
#Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $s0,12($sp)
#Khai bao
	li $t1,0 #bien i
	la $s0,($a1)#s0 la bien luu ket qua
#Than thu tuc
_CongKyTu.Lap: #Moi vong lap gan str[i] vao $v0[i]
	lb $t0,($a1)
	sb $t0,($s0)
	addi $a1,$a1,1
	addi $s0,$s0,1
	addi $t1,$t1,1
	bne $t0,'\0',_CongKyTu.Lap
	#Gan $v0[str.lenght()]=$a0
	addi $s0,$s0,-1
	sb $a0,($s0)
	#Gan phan tu ket thuc chuoi \0 vao cuoi chuoi $v0
	addi $s0,$s0,1
	li $a0,'\0'
	sb $a0,($s0)
	#Tra ve dia chi ban dau cho $s0
	sub $s0,$s0,$t1
	move $v0,$s0
#Cuoi thu tuc
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $s0,12($sp)
	addi $sp,$sp,32
	jr $ra
#----------------------------------------------------------------------
_InChu: #Ham in ra 1 chuoi dang |          aaaa         |
#$a0: chuoi can in, $a1(bool): in vien tren, $a2(bool): in vien duoi
#Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	sw $a3,24($sp)
#Than thu tuc
	move $a3,$a0
	la $a0,vien
	beq $a1,1,_InChu.InVien1
	_InChu.InVien1.TiepTuc:
	#In dau |
	la $a0,'|'
	li $v0,11
	syscall

	#Xac dinh khoang trong co do lon bao nhieu
	move $a0,$a3
	jal _StringLength #Xac dinh do dai cua input
	
	li $t0,2
	div $v0,$t0
	mflo $t1 #t3 la do dai cua khoang trong
	mfhi $t4 #t4 la so du khi chia do dai input cho 2
	li $t2,24
	sub $t3,$t2,$t1
	blez $t3,_InChu.VuotGioiHan
	li $t0,0
_InChu.InKhoangTrong1:
	la $a0,' '
	li $v0,11
	syscall
	addi $t0,$t0,1
	bne $t0,$t3,_InChu.InKhoangTrong1

	#In chuoi
	move $a0,$a3
	li $v0,4
	syscall

	li $t0,0
	addi $t3,$t3,-1
_InChu.InKhoangTrong2:
	la $a0,' '
	li $v0,11
	syscall
	addi $t0,$t0,1
	bne $t0,$t3,_InChu.InKhoangTrong2

	beq $t4,1,_InChu.Nhay
	beqz $t4,_InChu.InDauCach
	_InChu.InDauCach:
	la $a0,' '
	li $v0,11
	syscall
	_InChu.Nhay:
	_InChu.VuotGioiHan.TiepTuc:
	#In dau |
	la $a0,'|'
	li $v0,11
	syscall

	la $a0,vien
	beq $a2,1,_InChu.InVien2
	_InChu.InVien2.TiepTuc:

	#In ky tu xuong dong
	la $a0,'\n'
	li $v0,11
	syscall
#Cuoi thu tuc:
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	lw $a3,24($sp)
	addi $sp,$sp,32
#Ket thuc
	jr $ra
_InChu.InVien1:
	li $v0,4
	syscall
	j _InChu.InVien1.TiepTuc
_InChu.InVien2:
	li $v0,4
	syscall
	j _InChu.InVien2.TiepTuc
_InChu.VuotGioiHan:
	#In chuoi
	move $a0,$a3
	li $v0,4
	syscall
	j _InChu.VuotGioiHan.TiepTuc
#----------------------------------------------------------------------
_StringLength: #Ham tra ve do dai 1 string, $a0: chuoi, $v0: do dai chuoi
#Dau thu tuc
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0,4($sp)
#Khoi tao
	li $v0,0
#Than thu tuc
_StringLength.Loop:
	lb $t0,($a0)
	addi $a0,$a0,1
	addi $v0,$v0,1
	bne $t0,'\0',_StringLength.Loop
#Cuoi thu tuc
	addi $v0,$v0,-1
	lw $ra,($sp)
	lw $t0,4($sp)
	addi $sp,$sp,32
	jr $ra
    _KetThuc:
    li $v0,10
    syscall

#--------------------------------------------------------------------VINH---------------------------------------------------------------------#

#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#

#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#
