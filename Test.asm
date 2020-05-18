#Test
.data
	fQuestion: .asciiz "question.txt"
	fScore: .asciiz "score.txt"
	nQuestion: .word 0
	
	question: .space 1000000
	score: .space 1000000

	answer: .space 15
	suggestion: .space 1
	
	
#Ham doc file
#Nhan vao $a0 la duong dan file, $a1 la flag voi 0: read, 1: write, $a2 la mode (auto ignored)
.text
	.globl main
main:

	jal _File.ReadFile.Question

	la $a0, question
	jal _Question.Get.N
	sw $v0, nQuestion
	li $v0, 1
	lw $a0, nQuestion
	syscall
	
	li $v0, 11
	la $a0, '\n'
	syscall

	#Test lay ra bo cau hoi thu 2
	li $a0, 22
	jal _Question.Get.Question.I

	li $v0, 4
	la $a0, answer
	syscall

	li $v0, 11
	la $a0, '\n'
	syscall

	li $v0 4,
	la $a0, suggestion
	syscall

	j Exit

_File.OpenFile.ForRead: 
	addi $sp, $sp, -16
	sw $a0, ($sp)
	sw $a1, 4($sp)
	sw $a2, 8($sp)
	sw $ra, 12($sp)

	li $v0, 13
	li $a1, 0
	li $a2, 0
	syscall

	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16

	jr $ra

_File.OpenFile.ForWrite: 
	addi $sp, $sp, -16
	sw $a0, ($sp)
	sw $s1, 4($sp)
	sw $a2, 8($sp)
	sw $ra, 12($sp)

	li $v0, 13
	li $a1, 1
	li $a2, 0
	syscall

	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16

	jr $ra

_File.ReadFile.Question:
	addi $sp, $sp, -16
	sw $a0, ($sp)
	sw $s1, 4($sp)
	sw $a2, 8($sp)
	sw $ra, 12($sp)

	#Mo file de doc
	la $a0, fQuestion
	jal _File.OpenFile.ForRead
	
	#Dua descriptor vao tham so $a0
	move $a0, $v0  
	
	#Doc file
	li $v0, 14
	la $a1, question
	li $a2, 1000000
	syscall

	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16

	jr $ra

_File.ReadFile.Score:
	addi $sp, $sp, -16
	sw $a0, ($sp)
	sw $s1, 4($sp)
	sw $a2, 8($sp)
	sw $ra, 12($sp)
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
	#Mo file de doc
	la $a0, fScore
	jal _File.OpenFile.ForRead
	
	#Dua descriptor vao tham so $a0
	move $a0, $v0  
	
	#Doc file
	li $v0, 14
	la $a1, score
	li $a2, 1000000
	syscall

	li $v0, 4
	la $a0, score
	syscall

	lw $a0, ($sp)
	lw $a1, 4($sp)
	lw $a2, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16

	jr $ra

#Lay ra so cau hoi trong de, Ham nhan vao $a0: noi dung file Question tho. Tra ve $v0 la so de bai dang int
_Question.Get.N:
	addi $sp, $sp, -16
	sw $a0, ($sp)
	sw $t0, 4($sp)
	sw $t1, 8($sp)
	sw $ra, 12($sp)

	li $v0, 0
	
_Question.Get.N.Loop:
	lb $t0, ($a0)
	
	beq $t0, '-', _Question.Get.N.End

	addi $a0, $a0, 1

	#Dung $t1 lam so 10
	li $t1, 10

	mult $v0, $t1
	mflo $v0
		
	subi $t0, $t0, 48

	add $v0, $v0, $t0
	j _Question.Get.N.Loop

_Question.Get.N.End:
	lw $a0, ($sp)
	lw $t0, 4($sp)
	lw $t1, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16

	jr $ra


#Nhan vao $a0 la stt cau hoi can lay ra, tra ve $v0 la dap an, $v1 la goi y
_Question.Get.Question.I:
	addi $sp, $sp, -20
	sw $a0, ($sp)
	sw $s0, 4($sp)
	sw $t0, 8($sp)
	sw $t1, 12($sp)
	sw $ra, 16($sp)

	la $v0, answer
	la $v1, suggestion

	la $s0, question
	li $t1, 0

_Question.Ignore.n_1_Question:
	lb $t0, ($s0)
	
	beq $t0, '-', _Increase_Count
	
	addi $s0, $s0, 1

	j _Question.Ignore.n_1_Question

_Increase_Count:
	addi $t1, $t1, 1
	addi $s0, $s0, 1

	beq $t1, $a0, _Question.Get.Answer

	j _Question.Ignore.n_1_Question
	
_Question.Get.Answer:
	lb $t0, ($s0)
	
	beq $t0, '/', _Question.PrepareGetSuggestion
	
	sb $t0, ($v0)

	addi $v0, $v0, 1
	addi $s0, $s0, 1

	j _Question.Get.Answer
	
_Question.PrepareGetSuggestion:
	sb $0, ($v0)
	addi $s0, $s0, 1
	j _Question.Get.Suggestion

_Question.Get.Suggestion:
	lb $t0, ($s0)
	
	beq $t0, '-', _Question.Get.Question.I.EndLoop

	sb $t0, ($v1)
	
	addi $v1, $v1, 1
	addi $s0, $s0, 1
	
	j _Question.Get.Suggestion
	
_Question.Get.Question.I.EndLoop:
	sb $0, ($v1)
	
	lw $a0, ($sp)
	lw $s0, 4($sp)
	lw $t0, 8($sp)
	lw $t1, 12($sp)
	lw $ra, 16($sp)
	addi $sp, $sp, 20

	jr $ra

Exit:
