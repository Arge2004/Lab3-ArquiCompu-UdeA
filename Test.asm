.text

main: 
	nor $v0, $zero, $zero
	jal second
	nor $v0, $zero, $zero

second:
	j main

