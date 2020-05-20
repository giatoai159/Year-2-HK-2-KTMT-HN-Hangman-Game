#Test
.data
	fQuestion: .asciiz "question.txt"
	fScore: .asciiz "score.txt"
	nQuestion: .word 0
	nScore: .word 0	

	question: .space 1000000
	score: .space 1000000
	test: .asciiz "4-Huy"
	answer: .space 20
	suggestion: .space 1000
	
	score_arr_int: .word 0:11

#Ham doc file
#Nhan vao $a0 la duong dan file, $a1 la flag voi 0: read, 1: write, $a2 la mode (auto ignored)
.text
	.globl main
main:
	la 	$a0, test
	jal	_Score.Process

	j 	Exit

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

#Lay ra so nguoi choi trong file diem. Nhan vao $a0 la noi dung tho cua file diem, tra ve $v0 la so nguoi dang int
_Score.Get.N:
	addi	 $sp, $sp, -20
	sw 	$a0, ($sp)
	sw 	$t0, 4($sp)
	sw 	$t1, 8($sp)
	sw	$v0, 12($sp)
	sw 	$ra, 16($sp)

	li 	$v0, 0
	
_Score.Get.N.Loop:
	lb 	$t0, ($a0)
	
	beq 	$t0, '/', _Score.Get.N.End

	addi 	$a0, $a0, 1

	#Dung $t1 lam so 10
	li 	$t1, 10

	mult 	$v0, $t1
	mflo	 $v0
		
	subi 	$t0, $t0, 48

	add 	$v0, $v0, $t0
	j 	_Score.Get.N.Loop

_Score.Get.N.End:
	sw 	$v0, nScore

	lw 	$a0, ($sp)
	lw 	$t0, 4($sp)
	lw 	$t1, 8($sp)
	lw	$v0, 12($sp)
	lw 	$ra, 16($sp)
	addi 	$sp, $sp, 20
 
	jr 	$ra

#Nhan vao $a0 la diem cua nguoi choi moi
_Score.Process:
	addi 	$sp, $sp, -20
	sw 	$a0, ($sp)
	sw 	$s0, 4($sp)
	sw 	$t0, 8($sp)
	sw 	$t1, 12($sp)
	sw 	$ra, 16($sp)
	
	#Do?c file diem
	jal 	_File.ReadFile.Score

	#Lay ra noi dung file diem tho, tinh so nguoi trong file cu
	la 	$a0, score
	jal	_Score.Get.N

	#Cong so nguoi them 1 vi them diem nguoi choi moi vao
	lw 	$t0, nScore
	addi 	$t0, $t0, 1
	sw 	$t0, nScore

#Them nguoi choi moi vao file diem tho
	
	#Lay ra file diem tho
	la $s0, score
	
_Score.Process.Append_New_Score.Load_End:
	lb $t0, ($s0)

	beq $t0, 0, _Score.Process.Append_New_Score.Append.Prepare

	addi $s0, $s0, 1

	j _Score.Process.Append_New_Score.Load_End
	
_Score.Process.Append_New_Score.Append.Prepare:
	li $t0, 47
	sb $t0, ($s0)

	addi $s0, $s0, 1
	lw $a0, ($sp)

	j _Score.Process.Append_New_Score.Append

_Score.Process.Append_New_Score.Append:
	lb $t0, ($a0)
	sb $t0, ($s0)

	beq $t0, 0, _Score.Process.Sort

	addi $a0, $a0, 1
	addi $s0, $s0, 1
	
	j _Score.Process.Append_New_Score.Append
	
_Score.Process.Sort:
	

_Score.Process.End:
	lw 	$a0, ($sp)
	lw 	$s0, 4($sp)
	lw 	$t0, 8($sp)
	lw 	$t1, 12($sp)
	lw 	$ra, 16($sp)
	addi 	$sp, $sp, 20

	jr $ra
	
NewLine:
	addi	$sp, $sp, -8
	sw 	$a0, ($sp)
	sw 	$ra, 4($sp)

	li 	$v0, 11
	li 	$a0, '\n'
	syscall

	lw 	$a0, ($sp)
	lw 	$ra, 4($sp)
	addi 	$sp, $sp, 8

	jr 	$ra
Exit:
