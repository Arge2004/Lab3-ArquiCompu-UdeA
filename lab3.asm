#Laboratorio 3

#Objetivo: programa que toma un vector de 16 valores y los ordena de forma descendente, 
#	   indicando cuantos elementos son pares e impares

#Algoritmo utilizado: Selection Sort

.data
array: .word 12, -5, 34, 0, 1024, -999, 87, 56, 2147483647, -2147483648, 300, -450, 72, 19, -2048, 4096



.text

# Rutina principal
# Variables utilizadas:
# $s0 - posición del array a partir del cual se están comparando los valores siguientes
main:
	# Carga de argumentos direcciones del arreglo
	
	add $a0, $s0, $zero # Dirección base del array
	addi $a1, $zero, 60 # Dirección final del array
	
	# Verificar si ya se revisaron todas las posiciones
	beq $s0, $a1, end_main
	
	# Llamado a la función find_greatest()
	jal find_greatest
	
	# Carga de argumentos
	
	add $a0, $v1, $zero # Dirección de la palabra a reemplazar
	add $a1, $s0, $zero # Dirección de destino
	add $a2, $v0, $zero # Valor de la palabra a colocar en $a0
	
	# Llamado a la función swap_word()
	jal swap_word

	
	# Siguiente posición base del array 
	addi $s0, $s0, 4
	j main
	
end_main:

	# Carga de argumentos
	add $a0, $zero, $zero # Reiniciar dirección base del array
	addi $a1, $zero, 60   # Reiniciar dirección final del array
	
	# Llamado a la función even_odd()
	jal even_odd
	
	# Salto a dirección donde no hay más instrucciones
	j final_end

	
#################################################	
# Función find_greatest(dirección base, dirección final)
# Argumentos:
# a0-dirección base del array
# a1-dirección final del array

# Variables locales:
# t0-número más grande
# t1-dirección del número mas grande
# t2-palabra actual a comparar
# t3-resultado de: $t0 < $t3 ?

# Valores de retorno:
# v0-número mas grande
# v1-dirección del número más grande
find_greatest:
	# Carga de la primera palabra
	lw $t0, 0($a0)
	add $t1, $a0, $zero
	for_find:
		# Verificar si ya se recorrio todo el array desde la posición base
		beq $a0, $a1, end_find_greatest
		lw $t2, 4($a0)
		
		# Siguiente palabra
		addi $a0, $a0, 4

		# Berificar si la ultima palabra cargada es mas grande que la cargada en $t0
		slt $t3, $t0, $t2
		beq $t3, $zero, for_find

		# Actualizar la palabra más grande
		add $t0, $t2, $zero
		add $t1, $a0, $zero

		j for_find

end_find_greatest:

	# Carga de valores de salida
	add $v0, $t0, $zero
	add $v1, $t1, $zero
	
	jr $ra
	
#################################################
# Función void swap_word (dirección a reemplazar, dirección de destino, palabra a cambiar)
# Argumentos:
# a0-dirección de la palabra a reemplazar
# a1-dirección de destino de la palabra reemplazada
# a2-palabra a cambiar en la dirección de $a0

# Variables locales
# t0: copia de la palabra a ser reemplazada
swap_word:
	# Cargar copia
	lw $t0, 0($a1)
	
	# Realizar intercambio
	sw $a2, 0($a1)
	sw $t0, 0($a0)
	
end_swap_word:
	jr $ra

#################################################
# función even_odd(dirección base, dirección final):
# a0-dirección base del array
# a1-dirección final del array
# Variables locales:
# $t0-flag de parada
# $t1-palabra a clasificar
# Valores de retorno:
# v0: valor de números impares
# v1: valores de número pares
even_odd:
	# Validar que los contadores inicien en zero
	add $v0, $zero, $zero
	add $v1, $zero, $zero
	for_even:
		# Verificar si ya se recorrió todo el array
		slt $t0, $a1, $a0
		beq $t0, 1, end_even_odd
		
		# cargar palabra a comparar
		lw $t1, 0($a0)
		
		# siguiente palabra
		addi $a0, $a0, 4
		
		# operación logica que permite ver si el bit menos significativo es 1 o 0
		andi $t1, $t1, 1
		
		# Si ese bit 0, es par de lo contrario es impar
		beq $t1, $zero, is_even
		# Aumentar impares
		add $v0, $v0, 1
		j for_even
		is_even:
			# Aumentar pares
			addi $v1, $v1, 1
			j for_even
end_even_odd:
	jr $ra


final_end:
