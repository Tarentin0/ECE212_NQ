.set noreorder
.global main # define main as a global label
.text
main:
    la $a0, str1
    addi $a1, $zero, 4 # put character shift amount in arg reg $a1
    jal encode_string # call the function
    add $0, $0, $0 # branch delay slot nop
    la $a0, str2
    addi $a1, $zero, 17 # put character shift amount in arg reg $a1
    jal encode_string # call the function
    add $0, $0, $0 # branch delay slot nop
    j done
    add $0, $0, $0 # branch delay slot nop
encode_string:
    add $t6, $a0, $0
    add $t4, $ra, $0
    lbu $a0, 0($t6)
    while:
	jal encode_char
	add $0, $0, $0 # branch delay slot nop
	sb $v0, 0($t6)
	addi $t6, $t6, 1
	lbu $a0, 0($t6)
	bne $a0, $0, while
	add $0, $0, $0 # branch delay slot nop
    jr $t4
    add $0, $0, $0 # branch delay slot nop
encode_char:
    li $t2, 'A'
    li $t3, 'Z'
    slt $t0, $a0, $t2
    slt $t1, $t3, $a0
    or $t0, $t0, $t1
    beq $t0, $0, else
    add $0, $0, $0 # branch delay slot nop
    add $v0, $0, $a0
    jr $ra
    add $0, $0, $0 # branch delay slot nop
else:
    sub $t0, $a0, 'A'
    sub $t0, $t0, $a1
    addi $t0, $t0, 26
    li $t1, 26
    div $t0, $t1
    mfhi $t0
    add $v0, $t0, 'A'
    jr $ra
    add $0, $0, $0 # branch delay slot nop
done:
    j done # infinite loop
    add $0, $0, $0 # branch delay slot
.data
str1:    
    .asciz "HELLO WORLD!"
str2:
    .asciz "ABCDE...WXYZ"

