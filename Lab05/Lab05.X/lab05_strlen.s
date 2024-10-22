

.set noreorder
.global main1 # define main as a global label
.text
main1:
    la $a0, msg1
    jal my_strlen
    add $0, $0, $0 # branch delay slot
    la $a0, msg2
    jal my_strlen
    add $0, $0, $0 # branch delay slot
    j done1
    add $0, $0, $0 # branch delay slot
my_strlen:
    add $v0, $0, $0 # i=0 ($v0 will also be return value)
nextchar:
    lbu $t0, 0($a0) # dereference the pointer
    beq $t0, $0, ret # we're done when we read '\0' (zero)
    add $0, $0, $0 # branch delay slot
    addi $v0, $v0, 1 # i++
    addi $a0, $a0, 1 # s++
    j nextchar
    add $0, $0, $0 # branch delay slot
ret:
    jr $ra # at end of string - return
    add $0, $0, $0 # branch delay
done1:
    j done1
    add $0, $0, $0 # branch delay slot
.data
msg1:
    .asciz "Example"
msg2:
    .asciz "WELCOME BACK MY FRIENDS 2 THE show THAT NEVER ENDS"

