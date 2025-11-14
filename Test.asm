.text

main: 
add $s2, $s0, $s1
sub $s3, $s0, $s1
slt $s4, $s3, $s2
beq $zero, $s2, main
add $v0, $s3, $s4

