# ============== V2 ==============

#     addi x1, x0, 7      # x1 = 7       x2 = 0
#     # nop
#     addi x2, x1, 10     # x1 = 7      x2 = 17
#     add  x2, x1, x1     # x1 = 7      x2 = 14
#     beq  x0, x0, shift
#     add  x2, x1, x1     # x1 = 7      x2 = 14
#     nop
#     nop
#     nop
#     nop
#     nop
#     nop

# shift:
#     slli x3, x2, 1     # x3 = 28
#     nop
# inf_loop:
#     addi x0, x3, 0
#     j inf_loop


#     nop
#     nop


# ============== V3 ==============

# addi x1, x0, 7      # x1 = 7      x2 = 0

# nop
# nop

# add  x2, x1, x0      # x1 = 7      x2 = 7

# nop
# nop

# beq  x1, x2, shift  # if x1 == x2 then shift

# addi  x2, x1, 3

# nop
# add x0, x2, x5

# shift:
# slli x3, x2, 1     # x3 = 14

# sub x0, x0, x0
# nop

# ============== GCD algo ==============


    # Store data into the RAM
init:
    addi s1, x0, 8

    # Store the value 10 in memeory location 0x0000_0000    (operand 1)
    addi t1, x0, 10
    sw t1, 0(s1)

    # Store the value 45 in memeory location 0x0000_0004    (operand 2)
    addi t1, x0, 45
    sw t1, 4(s1)

    # Store the value 0 in memeory location 0x0000_0008     (result)
    addi t1, x0, 0
    sw t1, 8(s1)
    
main:
    addi  a2, x0, 8         # address of data
    lw    a1, 4(a2)			# load the second integer from RAM in register a1 (b)
    nop

    lw    a0, 0(a2)			# load the first integer from RAM in register a0 (a)
    nop

gcd:
	jal   while_codition		# jump to the 
while_loop:
	blt   a0, a1, else		# branch to "else" label if a < b
	sub   a0, a0, a1		# a = a - b
	jal   while_codition
	
else:
	sub   a1, a1, a0		# b = b - a
	
while_codition:
	bne   a0, a1 while_loop		# while(a != b), do the loob
	
	addi  a1, x0, 8			# address of data
	sw    a0, 8(a1)			# store the final result in a0 to RAM (8 bytes offset)

    # add a0, a0, a1  # a0 = 55 [temp]
    # Display the result on the LEDs
    addi x23, x0, 0
    sw a0, 0(x23)

inf_loop:
    nop
    jal inf_loop

# ============== Memory W/R test ==============

    # Store the value 10 in memeory location 0x0000_0000    (operand 1)
#     addi x10, x0, 8         # x10 = 0x08 (addr)

#     addi x11, x0, 7         # x11 = 7    (imm/val)
#     sw x11, 0(x10)          # x11[val] -> x10[addr + 0]

#     addi x11, x0, 3         # x11 = 3    (imm/val)
#     sw x11, 4(x10)          # x11[val] -> x10[addr + 4]

#     lw    x1, 0(x10)		# x1 <- x10[addr + 0]
#     nop
#     lw    x2, 4(x10)		# x2 <- x10[addr + 4]
#     nop


#     add  x12, x1, x2        # x12 = x1 + x2
#     addi x12, x12, -5

#     # Display the result on the LEDs
#     # X23 = 0x00
#     addi x23, x0, 0
#     sw x12, 0(x23)           # x12[val]  -> x23[addr]

#     nop
#     nop
# inf_loop:
#     nop
#     nop
#     jal inf_loop