#Laboratorio 3

#Objetivo: programa que toma un vector de 16 valores y los ordena de forma descendente, 
#	   indicando cuantos elementos son pares e impares

.data
array: .word 12, -5, 34, 0, 1024, -999, 87, 56, 2147483647, -2147483648, 300, -450, 72, 19, -2048, 4096



.text

main:
	# preparing adresses for base and top of the array 
	add $a0, $s0, $zero
	nor $a1, $zero, $zero
	andi $a1, $a1, 60
	
	# checking if all the words were checked
	beq $s0, $a1, end_main

	jal find_greatest
	
	add $a0, $v1, $zero
	add $a1, $s0, $zero
	add $a2, $v0, $zero
	
	jal swap_word
	
	# constant to travers the array
	nor $t0, $zero, $zero
	andi $t0, $t0, 4
	
	add $s0, $s0, $t0
	j main
	
end_main:
	add $a0, $zero, $zero
	nor $a1, $zero, $zero
	andi $a1, $a1, 60
	jal even_odd

	li $v0, 10
	syscall
	
#################################################	
# a0: base array
# a1: top array

# t0: greatest number
# t1: greatest number address
# t2: constant 4
# t3: actual word to compare
# t4: is t0 lower than t3?

# v0: greatest number
# v1: greatest number address
find_greatest:
	# load firt word
	lw $t0, 0($a0)
	add $t1, $a0, $zero

	nor $t2, $zero, $zero
	andi $t2, $t2, 4
	
	for_find:
	# check if the arrya was traversed
	beq $a0, $a1, end_find_greatest
	lw $t3, 4($a0)

	add $a0, $a0, $t2

	# check if actual word is greater than the greatest gotten so far
	slt $t4, $t0, $t3
	beq $t4, $zero, for_find

	# update to greatest word
	add $t0, $t3, $zero
	add $t1, $a0, $zero

	j for_find

end_find_greatest:
	add $v0, $t0, $zero
	add $v1, $t1, $zero
	jr $ra
	
#################################################
# a0: address of word to change
# a1: adress to place the word
# a2: word to swap

# t0: copy of the word that is where the input word will be placed
swap_word:
	lw $t0, 0($a1)
	
	sw $a2, 0($a1)
	sw $t0, 0($a0)
	
	jr $ra

#################################################	
# a0: base array
# a1: top array


# t0: constant 1
# t1: constant 4
# t2: actual word
# t3: flag to know if the array was traversed
# t4: actual word and flag to know if the word is even

# v0: amount of odd numbers
# v1: amount of even numbers

even_odd:
	nor $t0, $zero, $zero
	andi $t0, $t0, 1
	
	nor $t1, $zero, $zero
	andi $t1, $t1, 4
	
	add $v0, $zero, $zero
	add $v1, $zero, $zero
	
for_even:
	slt $t3, $a1, $a0
	beq $t3, $t0, end_even_odd
	
	lw $t4, 0($a0)
	add $a0, $a0, $t1
	
	and $t4, $t4, $t0
	beq $t4, $zero, is_even
	
	add $v0, $v0, $t0
	j for_even
	
is_even:
	add $v1, $v1, $t0
	j for_even
	
end_even_odd:
	jr $ra