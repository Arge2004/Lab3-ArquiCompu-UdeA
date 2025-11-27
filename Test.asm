.text
main:


# 1. Cargar valores iniciales para pruebas y probar instrucción addi
    addi $t0, $zero, 5         # 5
    addi $t1, $zero, -3        # -3
    addi $t2, $zero, 255       # 0x00FF
    addi $t3, $zero, -1        # 0xFFFFFFFF

# 2. Probar ANDI (zero-extend)
    andi $s0, $t3, 0x00FF      

# 3. Probar ALU R-TYPE

    add $a0, $t0, $t2          # a0 = 5 + 255 = 260
    sub $a1, $t0, $t2          # a1 = 5 - 255 = -250
    and $a2, $t0, $t2          # a2 = 5 & 255 = 5
    or  $a3, $t0, $t2          # a3 = 5 | 255 = 255
    nor $s4, $t0, $t2          # s4 = NOR(5,255) -> 0xFFFFFF00
    slt $s5, $t1, $t0          # s5 = 1, porque -3 < 5

# 4. Probar memoria (LW / SW / LHU)
    addi $t4, $zero, 0      # dirección base para pruebas

    # guardar valores
    sw  $t0, 0($t4)            # mem[0] = 5
    sw  $t2, 4($t4)            # mem[4] = 255

    lw  $t5, 0($t4)            # t5 = 5
    lw  $t6, 4($t4)            # t6 = 255

    # probar LHU construyendo 
    addi $t0, $zero, 32767
    addi $t0, $t0, 32767
    addi $t0, $t0, 32767
    addi $t0, $t0, 32767 # valor final de $t0 = 0x0001fffc
    sw   $t0, 8($t4)
    lhu  $s6, 8($t4) # s6 = 0x0000fffc
    lhu  $s7, 10($t4) # s7 = 0x00000001

# 5. Probar BEQ
    beq $t0, $t0, beq_ok
    addi $v0, $zero, 111       # NO debe ejecutarse

beq_ok:
    addi $v0, $zero, 222       # v0 = 222

# 6. Probar JAL 
    jal jump_test
    addi $v1, $zero, 999       # NO se ejecuta

# 8. Probar Jump
after_jump:
    j end

# 7. Probar JR
jump_test:
    addi $v1, $zero, 123       # v1 = 123 si jal funcionó
    jr $ra

end:


