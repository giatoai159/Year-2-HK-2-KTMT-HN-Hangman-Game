.data
#--------------------------------------------------------------------TOAI---------------------------------------------------------------------#
	SoChanRandom: .word 0
	MaxRandom: .word 0
	tempString: .word 0
	ChuCaiDoan: .word 0
	TuCanDoan: .word 0
	choice: .word 0
	MENU: .asciiz "MENU"
	playgame: .asciiz "1. Choi game"
	hdsd: .asciiz "2. Huong dan choi"
	thanhvien: .asciiz "3. Thanh vien"
	thoat: .asciiz "4. Thoat"
	endline: .asciiz "\n"
	nhapluachon: .asciiz "Nhap lua chon: "
	inHUONGDANCHOI: .asciiz "Huong dan choi"
	huongdan1: .asciiz "Ban can doan 1 tu tieng anh ngau nhien,"
	huongdan2: .asciiz "neu doan sai 7 lan hoac"
	huongdan3: .asciiz "doan mot luc nguyen tu sai"
	huongdan4: .asciiz "thi ban se thua cuoc, neu"
	huongdan5: .asciiz "dung ban se duoc diem."
	inTHANHVIEN: .asciiz "Cac thanh vien cua nhom"
	thanhvien1: .asciiz "18120640 - Le Thanh Tung"
	thanhvien2: .asciiz "18120650 - Nguyen Tan Vinh"
	thanhvien3: .asciiz "18120632 - Le Nhat Tuan"
	thanhvien4: .asciiz "18120598 - Huynh Gia Toai"
	nhapluachonsai: .asciiz "Vui long chi nhap so tu 1 den 4. Xin vui long nhap lai."
	inHANGMAN: .asciiz "HANGMAN"
	pressany: .asciiz "Press any key to continue..."
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
	vien: .asciiz "\n+------------------------------------------------+\n"
	res: .asciiz ""
#--------------------------------------------------------------------VINH---------------------------------------------------------------------#
#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#
	fQuestion: .asciiz "question.txt"
	fScore: .asciiz "score.txt"
	nQuestion: .word 0
	nScore: .word 0	

	question: .space 1000000
	score: .space 1000000
	
	answer: .space 20
	suggestion: .space 1000
#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#
.text
	.globl main
main:
#--------------------------------------------------------TOAI----------------------------------------------------------------------#
MainMenu:
	# In MENU
	la $a0,MENU
	li $a1,1
	li $a2,1
	jal _InChu
	# In playgame
	la $a0,playgame
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In huong dan choi
	la $a0,hdsd
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In thanh vien
	la $a0,thanhvien
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In thoat
	la $a0,thoat
	li $a1,0
	li $a2,1
	jal _InChu
	# In chon
	li $v0,4
	la $a0,nhapluachon
	syscall
	li $v0,5
	syscall
	move $t0,$v0
	beq $t0,1,PLAYGAME
	beq $t0,2,HUONGDANCHOI
	beq $t0,3,THANHVIEN
	beq $t0,4,EXIT
	j MainMenu
PLAYGAME: # t0: Point , t1: Play again or not, t2: tries, t3: bool win or not, t4: level
	li $t0,0 # Point = 0
	li $t1,'y' # Play or play again = yes
PLAYGAME.playagain:
	beq $t1,'y',PLAYGAME.Loop
	beq $t1,'Y',PLAYGAME.Loop
	li $t3,0 # win = 0
	j LEADERBOARD
	PLAYGAME.Loop:
		# Get answer and hint
		jal _File.ReadFile.Question # Doc file
		la $a0,question
		jal _Question.Get.N # Lay N
		# Random number
		lw $a1,nQuestion # Move N -> a1 de random
		li $v0,42 # Random tu 0 -> N - 1
		syscall
		addi $a0,$a0,1 # Cong so random cho 1 vi ta se lay so tu 1 -> N
		# Lay answer, question
		jal _Question.Get.Question.I 
		li $t2,0 # tries = 0
		li $t3,0 # win = 0
		PLAYGAME.Loop.Playing:
			#In HANGMAN
			la $a0,inHANGMAN
			li $a1,1
			li $a2,1
			jal _InChu
			#In Hangman - WIP
			li $a0,7
			jal _InHangMan
			# Cac ki tu doan cua nguoi dung chua trong s3
			li $s3,0
			
		
		j MainMenu
LEADERBOARD:
	j MainMenu
HUONGDANCHOI:
	# In HUONGDANCHOI
	la $a0,inHUONGDANCHOI
	li $a1,1
	li $a2,1
	jal _InChu
	# In huongdan 1
	la $a0,huongdan1
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In huongdan 2
	la $a0,huongdan2
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In huongdan 3
	la $a0,huongdan3
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In huongdan 4
	la $a0,huongdan4
	li $a1,0
	li $a2,0
	jal _InChu
	la $v0,4
	la $a0,endline
	syscall
	# In huongdan 5
	la $a0,huongdan5
	li $a1,0
	li $a2,1
	jal _InChu
	# In press any
	li $v0,4
	la $a0,pressany
	syscall
	li $v0,12
	syscall
	j MainMenu
THANHVIEN:
	# In THANHVIEN
	la $a0,inTHANHVIEN
	li $a1,1
	li $a2,1
	jal _InChu
	# In thanhvien 1
	la $a0,thanhvien1
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In thanhvien 2
	la $a0,thanhvien2
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In thanhvien 3
	la $a0,thanhvien3
	li $a1,0
	li $a2,0
	jal _InChu
	li $v0,4
	la $a0,endline
	syscall
	# In thanhvien 4
	la $a0,thanhvien4
	li $a1,0
	li $a2,1
	jal _InChu
	# In press any
	li $v0,4
	la $a0,pressany
	syscall
	li $v0,12
	syscall
	j MainMenu
EXIT:   # ket thuc chuong trinh
	li $v0,10
	syscall

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
#----------------------------------------------------------------------
_InChuCai: #void InChuCai(string chucaidoan, char tu, char den)
#$a0: chucaidoan, $s1: tu, $s2: den
#Dau thu tuc:
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $s7,4($sp)
	sw $s0,8($sp)
	sw $s1,12($sp)
	sw $s2,16($sp)
	sw $t0,20($sp)
	sw $t2,24($sp)
	sw $t1,28($sp)
#Khoi tao
	move $s0,$a0 #string ban dau
	move $s1,$a1
	move $s2,$a2
	move $t0,$a1 #bien i
	la $s7,res #bien luu tru ket qua de in ra
#Than thu tuc
_InChuCai.Lap:
	move $a0,$t0
	la $a1,($s0)
	jal _Tim
	move $t2,$v0

	beq $t2,-1,InChuCai.CongKyTu1
	InChuCai.CongKyTu.TiepTuc1:

	beq $t2,-1,InChuCai.CongKyTu2
	InChuCai.CongKyTu.TiepTuc2:

	beq $t2,-1,InChuCai.CongKyTu5
	InChuCai.CongKyTu.TiepTuc5:

	bne $t2,-1,InChuCai.CongKyTu3
	InChuCai.CongKyTu.TiepTuc3:

	bne $t2,-1,InChuCai.CongKyTu4
	InChuCai.CongKyTu.TiepTuc4:

	bne $t2,-1,InChuCai.CongKyTu6
	InChuCai.CongKyTu.TiepTuc6:

	addi $t0,$t0,1
	addi $s0,$s0,1
	sub $t1,$s2,$t0 #$t1=$s2-$t0
	bgez $t1,_InChuCai.Lap #Neu $t1<=0 thi lap

	#Truyen tham so cho ham _InChu
	la $a0,($s7)
	li $a1,0
	li $a2,0
	jal _InChu
#Cuoi thu tuc
	lw $ra,($sp)
	lw $s7,4($sp)
	lw $s0,8($sp)
	lw $s1,12($sp)
	lw $s2,16($sp)
	lw $t0,20($sp)
	lw $t2,24($sp)
	lw $t1,28($sp)
	addi $sp,$sp,32
	jr $ra
#Ket thuc
	j _KetThuc
	
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

InChuCai.CongKyTu1:
	move $a0,$t0
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc1
InChuCai.CongKyTu2:
	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc2
InChuCai.CongKyTu5:
	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc5
InChuCai.CongKyTu3:
	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc3
InChuCai.CongKyTu4:
	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc4
InChuCai.CongKyTu6:
	li $a0,' '
	move $a1,$s7
	jal _CongKyTu
	move $s7,$v0
	j InChuCai.CongKyTu.TiepTuc6
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
#Cuoi thu tuc:
	lw $ra,($sp)
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	lw $a3,24($sp)
	addi $sp,$sp,32
	jr $ra
#Ket thuc
	j _KetThuc
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


#Ham m can dung la` _Question.Get.Question.I nha Toai. m lw vo $a0 cai so m random ra. xong m jal _Question.Get.Question.I la ok
#Phan dap an thi la answer, phan goi y thi la suggest. answer vs suggest t khai bao tren .data a'. 
#file de lay tren github luon nha. t dua ve dang chuan r.
#VD: File de: 3-CAT/(NOUN) a small domesticated carnivore.-DOG/(NOUN) a domesticated canid.- 
#m can lay de thu 2 thi m lam z ne
#gia su $t0 la bien ma m random ra, co gia tri la 2
#lw $a0, ($t0)
#jal _Question.Get.Question.I
#goi xong cai ham nay
#	answer: DOG
#	suggest: (NOUN) a domesticated canid.
#xong can cai nao thi cu 
#	la $s0, answer
#	la $s1, suggest
#Chang han v
#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#
_File.OpenFile.ForRead: 
	addi 	$sp, $sp, -16
	sw 	$a0, ($sp)
	sw 	$a1, 4($sp)
	sw 	$a2, 8($sp)
	sw 	$ra, 12($sp)

	li 	$v0, 13
	li 	$a1, 0
	li 	$a2, 0
	syscall

	lw 	$a0, ($sp)
	lw 	$a1, 4($sp)
	lw 	$a2, 8($sp)
	lw 	$ra, 12($sp)
	addi 	$sp, $sp, 16

	jr 	$ra

_File.OpenFile.ForWrite: 
	addi 	$sp, $sp, -16
	sw 	$a0, ($sp)
	sw 	$s1, 4($sp)
	sw 	$a2, 8($sp)
	sw 	$ra, 12($sp)

	li 	$v0, 13
	li 	$a1, 1
	li 	$a2, 0
	syscall

	lw 	$a0, ($sp)
	lw 	$a1, 4($sp)
	lw 	$a2, 8($sp)
	lw	$ra, 12($sp)
	addi 	$sp, $sp, 16

	jr 	$ra

_File.ReadFile.Question:
	addi 	$sp, $sp, -16
	sw 	$a0, ($sp)
	sw 	$s1, 4($sp)
	sw 	$a2, 8($sp)
	sw 	$ra, 12($sp)

	#Mo file de doc
	la 	$a0, fQuestion
	jal	_File.OpenFile.ForRead
	
	#Dua descriptor vao tham so $a0
	move 	$a0, $v0  
	
	#Doc file
	li	$v0, 14
	la 	$a1, question
	li 	$a2, 1000000
	syscall

	lw 	$a0, ($sp)
	lw	$a1, 4($sp)
	lw 	$a2, 8($sp)
	lw 	$ra, 12($sp)
	addi 	$sp, $sp, 16

	jr 	$ra

_File.ReadFile.Score:
	addi 	$sp, $sp, -16
	sw 	$a0, ($sp)
	sw 	$s1, 4($sp)
	sw 	$a2, 8($sp)
	sw 	$ra, 12($sp)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
	#Mo file de doc
	la 	$a0, fScore
	jal 	_File.OpenFile.ForRead
	
	#Dua descriptor vao tham so $a0
	move 	$a0, $v0  
	
	#Doc file
	li 	$v0, 14
	la 	$a1, score
	li 	$a2, 1000000
	syscall

	lw 	$a0, ($sp)
	lw 	$a1, 4($sp)
	lw 	$a2, 8($sp)
	lw 	$ra, 12($sp)
	addi 	$sp, $sp, 16

	jr 	$ra

#Lay ra so cau hoi trong de, Ham nhan vao $a0: noi dung file Question tho. Tra ve $v0 la so de bai dang int
_Question.Get.N:
	addi	$sp, $sp, -20
	sw 	$a0, ($sp)
	sw 	$t0, 4($sp)
	sw 	$t1, 8($sp)
	sw	$v0, 12($sp)
	sw 	$ra, 16($sp)

	li 	$v0, 0
	
_Question.Get.N.Loop:
	lb 	$t0, ($a0)
	
	beq 	$t0, '-', _Question.Get.N.End

	addi 	$a0, $a0, 1

	#Dung $t1 lam so 10
	li 	$t1, 10

	mult 	$v0, $t1
	mflo 	$v0
		
	subi 	$t0, $t0, 48

	add 	$v0, $v0, $t0
	j 	_Question.Get.N.Loop

_Question.Get.N.End:
	sw 	$v0, nQuestion

	lw 	$a0, ($sp)
	lw 	$t0, 4($sp)
	lw 	$t1, 8($sp)
	lw	$v0, 12($sp)
	lw 	$ra, 16($sp)
	addi 	$sp, $sp, 20
 
	jr 	$ra

#Nhan vao $a0 la stt cau hoi can lay ra, tra ve $v0 la dap an, $v1 la goi y
_Question.Get.Question.I:
	addi 	$sp, $sp, -20
	sw 	$a0, ($sp)
	sw 	$s0, 4($sp)
	sw 	$t0, 8($sp)
	sw 	$t1, 12($sp)
	sw 	$ra, 16($sp)

	la 	$v0, answer
	la 	$v1, suggestion

	la 	$s0, question
	li 	$t1, 0

_Question.Ignore.n_1_Question:
	lb 	$t0, ($s0)
	
	beq 	$t0, '-', _Question.Increase_Count
	
	addi 	$s0, $s0, 1

	j 	_Question.Ignore.n_1_Question

_Question.Increase_Count:
	addi 	$t1, $t1, 1
	addi 	$s0, $s0, 1

	beq 	$t1, $a0, _Question.Get.Answer

	j 	_Question.Ignore.n_1_Question
	
_Question.Get.Answer:
	lb 	$t0, ($s0)
	
	beq 	$t0, '/', _Question.PrepareGetSuggestion
	
	sb 	$t0, ($v0)

	addi 	$v0, $v0, 1
	addi 	$s0, $s0, 1

	j 	_Question.Get.Answer
	
_Question.PrepareGetSuggestion:
	sb 	$0, ($v0)
	addi 	$s0, $s0, 1
	j 	_Question.Get.Suggestion

_Question.Get.Suggestion:
	lb 	$t0, ($s0)
	
	beq 	$t0, '-', _Question.Get.Question.I.EndLoop

	sb 	$t0, ($v1)
	
	addi 	$v1, $v1, 1
	addi 	$s0, $s0, 1
	
	j 	_Question.Get.Suggestion
	
_Question.Get.Question.I.EndLoop:
	sb 	$0, ($v1)
	
	lw 	$a0, ($sp)
	lw 	$s0, 4($sp)
	lw 	$t0, 8($sp)
	lw 	$t1, 12($sp)
	lw 	$ra, 16($sp)
	addi 	$sp, $sp, 20

	jr	$ra

#--------------------------------------------------------------------TUAN---------------------------------------------------------------------#
