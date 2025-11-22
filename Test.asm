.text
main:

############################################################
# 1. Construcción de valores manualmente
############################################################
    addi $t0, $zero, 5         # 5
    addi $t1, $zero, -3        # -3
    addi $t2, $zero, 255       # 0x00FF
    addi $t3, $zero, -1        # 0xFFFFFFFF

############################################################
# 2. Probar ANDI (zero-extend)
############################################################
    andi $s0, $t3, 0x00FF      # s0 = 0x000000FF (prueba zero-extend)
    andi $s1, $t3, 0xF0F0      # s1 = 0x0000F0F0

############################################################
# 3. Probar ADDI (sign-extend)
############################################################
    addi $s2, $zero, -10       # s2 = -10
    addi $s3, $s2, 20          # s3 = 10

############################################################
# 4. Probar ALU R-TYPE
############################################################
    add $a0, $t0, $t2          # a0 = 5 + 255 = 260
    sub $a1, $t0, $t2          # a1 = 5 - 255 = -250
    and $a2, $t0, $t2          # a2 = 5 & 255 = 5
    or  $a3, $t0, $t2          # a3 = 5 | 255 = 255
    nor $s4, $t0, $t2          # s4 = NOR(5,255) -> 0xFFFFFF00
    slt $s5, $t1, $t0          # s5 = 1, porque -3 < 5

############################################################
# 5. Probar memoria (LW / SW / LHU)
############################################################
    addi $t4, $zero, 0      # dirección base para pruebas

    # guardar valores
    sw  $t0, 0($t4)            # mem[0] = 5
    sw  $t2, 4($t4)            # mem[4] = 255

    lw  $t5, 0($t4)            # t5 = 5
    lw  $t6, 4($t4)            # t6 = 255

    # probar LHU construyendo un halfword en memoria
    addi $t7, $zero, 0x1234
    sw   $t7, 8($t4)           # guarda 0x00001234
    lhu  $s6, 8($t4)           # s6 = 0x00001234

############################################################
# 6. Probar BEQ
############################################################
    beq $t0, $t0, beq_ok
    addi $v0, $zero, 111       # NO debe ejecutarse

beq_ok:
    addi $v0, $zero, 222       # v0 = 222

############################################################
# 7. Probar JAL y JR
############################################################
    jal jump_test
    addi $v1, $zero, 999       # NO se ejecuta

after_jump:
    j end

jump_test:
    addi $v1, $zero, 123       # v1 = 123 si jal funcionó
    jr $ra

end:
    j end

