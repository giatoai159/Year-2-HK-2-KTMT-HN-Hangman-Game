#Test
.data
	fQuestion: .asciiz "question.txt"
	fScore: .asciiz "score.txt"
	nQuestion: .word 0
	nScore: .word 0	

	question: .space 1000000
	score: .space 1000000

	answer: .space 20
	suggestion: .space 1000

	test: .asciiz "200-Huy-1"	
	slash: .asciiz "/"
	
	int_string_reverse: .space 12
	int_string_res: .space 12

	array: .space 0
	score_arr_int: .word 0:11
	score_arr_string_pointer: .word 0:11
	score_arr_string: .space 1000000


#Ham doc file
#Nhan vao $a0 la duong dan file, $a1 la flag voi 0: read, 1: write, $a2 la mode (auto ignored)
.text
	.globl main
main:
	la	$a0, test
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

	li 	$v0, 16
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

	li	$v0, 16
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
	beq 	$t0, $0, _Question.Get.N.End

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
	beq 	$t0, $0, _Question.Get.Question.I.EndLoop

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
	addi	$sp, $sp, -20
	sw 	$a0, ($sp)
	sw 	$t0, 4($sp)
	sw 	$t1, 8($sp)
	sw	$v0, 12($sp)
	sw 	$ra, 16($sp)

	li 	$v0, 0
	
_Score.Get.N.Loop:
	lb 	$t0, ($a0)
	
	beq 	$t0, '/', _Score.Get.N.End
	beq 	$t0, $0, _Score.Get.N.End

	addi 	$a0, $a0, 1

	#Dung $t1 lam so 10
	li 	$t1, 10

	mult 	$v0, $t1
	mflo	$v0
		
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
	addi 	$sp, $sp, -68
	sw 	$a0, ($sp)
	sw 	$a1, 4($sp)
	sw 	$a2, 8($sp)
	sw 	$a3, 12($sp)
	sw 	$s0, 16($sp)
	sw 	$s1, 20($sp)
	sw 	$s2, 24($sp)
	sw 	$s3, 28($sp)
	sw 	$s4, 32($sp)
	sw 	$s6, 36($sp)
	sw 	$t0, 40($sp)
	sw 	$t1, 44($sp)
	sw 	$t2, 48($sp)
	sw 	$t3, 52($sp)
	sw 	$t4, 56($sp)
	sw 	$t5, 60($sp)
	sw 	$ra, 64($sp)

	
	#Doc file diem
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
	la 	$s0, score

_Score.Process.Append_New_Score.Load_End:
	lb 	$t0, ($s0)

	beq 	$t0, 0, _Score.Process.Append_New_Score.Append.Prepare

	addi 	$s0, $s0, 1

	j 	_Score.Process.Append_New_Score.Load_End
	
_Score.Process.Append_New_Score.Append.Prepare:
	li 	$t0, 47
	sb 	$t0, ($s0)

	addi 	$s0, $s0, 1

	lw 	$a0, ($sp)

	j 	_Score.Process.Append_New_Score.Append

_Score.Process.Append_New_Score.Append:
	lb 	$t0, ($a0)
	sb 	$t0, ($s0)

	beq 	$t0, 0, _Score.Process.Store_Into_Array.Prepare

	addi 	$a0, $a0, 1
	addi 	$s0, $s0, 1
	
	j 	_Score.Process.Append_New_Score.Append
	
_Score.Process.Store_Into_Array.Prepare:
	la	$s0, score
	la	$s1, score_arr_string
	la	$t1, score_arr_string_pointer
	li	$t3, 0
	lw	$t4, nScore
	j	_Score.Process.Store_Into_Array.Split.Loop.Ignore_n
	
_Score.Process.Store_Into_Array.Split.Loop.Ignore_n:
	lb 	$t0, ($s0)
	addi 	$s0, $s0, 1

	beq 	$t0, '/', _Score.Process.Store_Into_Array.Split.Main_Loop.Prepare
	beq 	$t0, $0, _Score.Process.Store_Into_Array.Split.Main_Loop.Prepare

	j 	_Score.Process.Store_Into_Array.Split.Loop.Ignore_n

_Score.Process.Store_Into_Array.Split.Main_Loop.Prepare:
	sw	$s1, ($t1)

	j 	_Score.Process.Store_Into_Array.Main_Loop

_Score.Process.Store_Into_Array.Main_Loop:
	lb	$t0, ($s0)

	beq	$t0, '/', _Score.Process.Store_Into_Array.End_String
	beq	$t0, $0, _Score.Process.Store_Into_Array.End_String

	sb	$t0, ($s1)

	addi 	$s0, $s0, 1
	addi	$s1, $s1, 1

	j	_Score.Process.Store_Into_Array.Main_Loop

_Score.Process.Store_Into_Array.End_String:
	sb	$0, ($s1)

	addi 	$s1, $s1, 1
	addi 	$s0, $s0, 1

	addi	$t1, $t1, 4
	addi	$t3, $t3, 1

	beq	$t3, $t4, _Score.Process.Get_Score_Int.Prepare

	j 	_Score.Process.Store_Into_Array.Split.Main_Loop.Prepare

_Score.Process.Get_Score_Int.Prepare:
	la	$s0, score_arr_int
	la	$t1, score_arr_string_pointer
	li	$t3, 0
	j	_Score.Process.Get_Score_Int.Loop.Prepare

_Score.Process.Get_Score_Int.Loop.Prepare:
	li 	$t6, 10
	lw	$t2, ($t1)
	
	li	$t5, 0

	j	_Score.Process.Get_Score_Int.Loop

_Score.Process.Get_Score_Int.Loop:
	lb	$t0, ($t2) 
	
	beq 	$t0, '-', _Score.Process.Store_Int_Into_Array

	mult 	$t5, $t6
	mflo	$t5
		
	subi 	$t0, $t0, 48

	add 	$t5, $t5, $t0

	addi	$t2, $t2, 1

	j 	_Score.Process.Get_Score_Int.Loop
	
_Score.Process.Store_Int_Into_Array:
	sw	$t5, ($s0)
	
	addi	$t3, $t3, 1
	addi 	$s0, $s0, 4
	addi	$t1, $t1, 4

	beq	$t3, $t4, _Score.Process.Sort.Prepare

	j 	_Score.Process.Get_Score_Int.Loop.Prepare
	
_Score.Process.Sort.Prepare:
	la	$t1, score_arr_string_pointer
	la 	$a1, score_arr_int
	
	li	$s1, 0

	j	_Score.Process.Sort.Loop_1

_Score.Process.Sort.Loop_1:
	lw	$s3, ($a1)
	add	$s2, $s1, 1
	
	beq	$s2, $t4, _Score.Process.Print.Prepare
	
	la	$a2, ($a1)
	addi	$a2, $a2, 4

	la	$t2, ($t1)
	addi	$t2, $t2, 4

	j 	_Score.Process.Sort.Loop_2

_Score.Process.Sort.Loop_2:
	lw	$s4, ($a2)
	slt	$t0, $s3, $s4

	beq 	$t0, 1, swap
	
	addi	$s2, $s2, 1
	addi	$a2, $a2, 4
	addi	$t2, $t2, 4

	bne	$s2, $t4, _Score.Process.Sort.Loop_2

	addi	$s1, $s1, 1
	addi	$a1, $a1, 4
	addi	$t1, $t1, 4

	bne	$s1, $t4, _Score.Process.Sort.Loop_1

	j	_Score.Process.Print.Prepare

swap:
	lw	$v0, ($a1)
	lw	$v1, ($a2)
	sw	$v0, ($a2)
	sw	$v1, ($a1)

	lw	$s3, ($a1)

	lw	$v0, ($t1)
	lw	$v1, ($t2)
	sw	$v0, ($t2)
	sw	$v1, ($t1)


	addi	$s2, $s2, 1
	addi	$a2, $a2, 4
	addi	$t2, $t2, 4

	bne	$s2, $t4, _Score.Process.Sort.Loop_2

	addi	$s1, $s1, 1
	addi	$a1, $a1, 4
	addi	$t1, $t1, 4

	bne	$s1, $t4, _Score.Process.Sort.Loop_1

	j	_Score.Process.Print.Prepare

_Score.Process.Print.Prepare:
	la	$t1, score_arr_string_pointer
	li 	$t3, 0

	li	$t0, 10

	bgt	$t4, $t0, _Score.Dec_nScore

	j	_Score.Process.Print.Loop

_Score.Dec_nScore:
	subi	$t4, $t4, 1
	sw	$t4, nScore

	j	_Score.Process.Print.Loop

_Score.Process.Print.Loop:
	lw	$t2, ($t1)
	li	$v0, 4
	la	$a0, ($t2)
	syscall
	jal	NewLine

	addi 	$t3, $t3, 1
	addi 	$t1, $t1, 4
	
	beq 	$t3, $t4, _Score.Process.WriteToFile.Prepare

	j	_Score.Process.Print.Loop

_Score.Process.WriteToFile.Prepare:
	la	$a0, fScore
	jal	_File.OpenFile.ForWrite

	move	$s6, $v0 #get Descriptor

	j	_Score.Process.WriteToFile.Write_nScore

_Score.Process.WriteToFile.Write_nScore:
	lw	$a0, nScore
	jal 	_Convert_Int_To_String

	la	$a0, int_string_res
	jal	_StringLength

	move	$t0, $v0
	move	$a0, $s6

	li	$v0, 15
	la	$a1, int_string_res
	la	$a2, ($t0)
	syscall

	li	$v0, 15
	la	$a1, slash
	li	$a2, 1
	syscall

	j	_Score.Process.WriteToFile.Write_Score

_Score.Process.WriteToFile.Write_Score:

	la	$t1, score_arr_string_pointer
	li 	$t3, 0
	lw	$t4, nScore

	j	_Score.Process.WriteToFile.Write_Score.Loop

_Score.Process.WriteToFile.Write_Score.Loop:
	lw	$t2, ($t1)
	la	$a0, ($t2)
	jal 	_StringLength

	move	$t0, $v0
	move	$a0, $s6

	li	$v0, 15
	la	$a1, ($t2)
	la	$a2, ($t0)
	syscall

_Score.Process.WriteToFile.WriteSlash:
	addi	$t3, $t3, 1
	addi	$t1, $t1, 4
	
	beq	$t3, $t4, _Score.Process.End

	li	$v0, 15
	la	$a1, slash
	li	$a2, 1
	syscall

	j	_Score.Process.WriteToFile.Write_Score.Loop
	
_Score.Process.End:
	move	$a0, $s6
	li	$v0, 16
	syscall

	#lw 	$a0, ($sp)
	#lw 	$s0, 4($sp)
	#lw 	$t0, 8($sp)
	#lw 	$t1, 12($sp)
	#lw 	$ra, 16($sp)
	#addi 	$sp, $sp, 20

	lw 	$a0, ($sp)
	lw 	$a1, 4($sp)
	lw 	$a2, 8($sp)
	lw 	$a3, 12($sp)
	lw 	$s0, 16($sp)
	lw 	$s1, 20($sp)
	lw 	$s2, 24($sp)
	lw 	$s3, 28($sp)
	lw 	$s4, 32($sp)
	lw 	$s6, 36($sp)
	lw 	$t0, 40($sp)
	lw 	$t1, 44($sp)
	lw 	$t2, 48($sp)
	lw 	$t3, 52($sp)
	lw 	$t4, 56($sp)
	lw 	$t5, 60($sp)
	lw 	$ra, 64($sp)

	jr 	$ra
	
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

_StringLength: #Ham tra ve do dai 1 string, $a0: chuoi, $v0: do dai chuoi
#Dau thu tuc
	addi 	$sp, $sp,-32
	sw 	$ra, ($sp)
	sw 	$t0, 4($sp)
#Khoi tao
	li 	$v0, 0
#Than thu tuc
_StringLength.Loop:
	lb 	$t0, ($a0)
	addi 	$a0, $a0,1
	addi 	$v0, $v0,1
	bne 	$t0,'\0',_StringLength.Loop
#Cuoi thu tuc
	addi 	$v0, $v0, -1
	lw 	$ra, ($sp)
	lw	$t0, 4($sp)
	addi 	$sp, $sp, 32
	jr 	$ra


#Ham nhan vao a0 la so int, tra ve $v0 la chuoi
_Convert_Int_To_String:
	addi	$sp, $sp, -20
	sw	$a0, ($sp)
	sw	$t0, 8($sp)
	sw	$t1, 12($sp)
	sw	$ra, 16($sp)

	la	$v0, int_string_reverse
	li	$t0, 10	
	
	j	_Convert_Int_To_String.Loop
	

_Convert_Int_To_String.Loop:
	div 	$a0, $t0

	mflo	$a0
	mfhi	$t1

	addi	$t1, $t1, '0'

	sb	$t1, ($v0)
	addi	$v0, $v0, 1

	beq	$a0, $0, _Reverse.Prepare

	j 	_Convert_Int_To_String.Loop

_Reverse.Prepare:
	sb	$0, ($v0)
	la	$a0, int_string_reverse
	
	jal	_Reverse
	j	_Convert_Int_To_String.End
	
_Convert_Int_To_String.End:
	lw	$a0, ($sp)
	lw	$t0, 8($sp)
	lw	$t1, 12($sp)
	lw	$ra, 16($sp)

	addi	$sp, $sp, 20

	jr 	$ra

#Nhan vao $a0 la chuoi goc, tra ve $v0 la chuoi dao
_Reverse:
	addi	$sp, $sp, -20

	sw	$a0, ($sp)
	sw	$t0, 8($sp)
	sw	$t1, 12($sp)
	sw	$ra, 16($sp)
	
	jal	_StringLength
	move	$t0, $v0
	
	la	$v0, int_string_res
	lw	$a0, ($sp)

	j	_Reverse.Prepare.Loop

_Reverse.Prepare.Loop:
	addi 	$a0, $a0, 1
	lb	$t1, ($a0)

	bne 	$t1, $0, _Reverse.Prepare.Loop
	j	_Reverse.Loop

_Reverse.Loop:	
	subi 	$a0, $a0, 1

	lb 	$t1, ($a0)
	sb 	$t1, ($v0)

	addi 	$v0, $v0, 1
	subi 	$t0, $t0, 1

	bne 	$t0, 0, _Reverse.Loop

	j	_Reverse.End

_Reverse.End:
	sb	$0, ($v0)

	lw	$a0, ($sp)
	lw	$t0, 8($sp)
	lw	$t1, 12($sp)
	lw	$ra, 16($sp)

	addi	$sp, $sp, 20

	jr 	$ra

	jr	$ra

Exit:



	
