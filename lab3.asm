#Laboratorio 3

#Objetivo: programa que toma un vector de 16 valores y los ordena de forma ascendente, 
#	   indicando cuantos elementos son negativos y cuantos positivos

.data
array: .word 12, -5, 34, 0, 1024, -999, 87, 56, 2147483647, -2147483648, 300, -450, 72, 19, -2048, 4096



.text

main:
	addi $a0, $zero, 16
	addi $a1, $zero, 0
	jal func_sort
end:
	nop







# Entradas
# - a0 : array lenght
# - a1 : dirección base del array
# Selection Sort

func_sort:
    add  $t0, $zero, $a0      # copia del array length
    add  $t1, $zero, $a0      # copia del array length para disminuir
    add  $t2, $zero, $a1      # posición base del array
    addi $t3, $zero, 0        # inicializar contador en 0
    
    for_sort:
    	
    	addi $sp, $sp, -16      
    	sw   $t0,  0($sp)        
    	sw   $t1,  4($sp)        
    	sw   $t2,  8($sp)       
    	sw   $t3, 12($sp)         
   
    	add  $a1, $zero, $t1
    	add  $a0, $zero, $t2
    	jal  func_compare
    	
	lw   $t0,  0($sp)
    	lw   $t1,  4($sp)
    	lw   $t2,  8($sp)
    	lw   $t3, 12($sp)
   	addi $sp, $sp, 16
   	          
   	 # Intercambio
   	lw   $t4, 0($v0)
   	lw   $t5, 0($t2)
    	sw   $t4, 0($t2)
    	sw   $t5, 0($v0)

    	addi  $t2, $t2, 4       # siguiente posición
    	addi  $t3, $t3,  1       # aumentar contador
    	addi  $t1, $t1, -1
		
    	beq  $t0, $t3, end_sort   # comparar con el tamaño del array
    	j    for_sort

end_sort:
    jr   $ra
	
# Procedimiento de Comparación

func_compare:
    add  $t0, $zero, $a0     # t0 = dirección actual
    lw   $t3, 0($t0)         # t3 = valor del menor
    add  $t7, $zero, $a0     # t7 = dirección del menor actual
    add  $t2, $zero, $a1     # t2 = contador (n elementos)
    addi $t1, $zero, 4       # t1 = constante 4 (tamaño palabra)

	loop_compare:
    	addi $t2, $t2, -1        # decrementar contador
    	beq  $t2, $zero, end_compare  # si t2 == 0 → terminar

    	add  $t0, $t0, $t1       # avanzar a la siguiente palabra
    	lw   $t4, 0($t0)         # cargar valor actual
    	slt  $t6, $t3, $t4       # t6 = 1 si $t4 > $t3
    	beq  $t6, $zero, loop_compare  # si no es mayor → continuar

    	# nuevo mínimo encontrado
    	add  $t3, $zero, $t4     # actualizar valor del menor
    	add  $t7, $zero, $t0     # guardar dirección del nuevo menor
    	j    loop_compare

end_compare:
    add  $v0, $zero, $t7     # devolver dirección del menor
    jr   $ra
	
	
	
	
