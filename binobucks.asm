	.data	# declare variables in memory
intro:	.asciiz "Greetings! I'm your robot bank teller.\n"
prompt: .asciiz "How many power-of-two dollars do you want?\n"

dollar:	.asciiz " dollar bill\n"
	
	.text	# program instructions follow .text

	# main instruction label
main: 	.macro print_int
	li $v0, 1
	syscall
	.end_macro
	
	.macro print_str
	li $v0,	4
	syscall
	.end_macro
	
	.macro done
	li $v0, 10
	syscall
	.end_macro
	
	.macro check (%power)
	sll	$t1, $t0, %power 
	div 	$a0, $a0, $t1
	mflo	$a0
	print_int
	
	li $a0, 32 	# print whitepace as line separator
	li $v0, 11	# syscall for char print
	syscall
	
	la	$a0, ($t1)
	print_int
	la	$a0, dollar
	print_str
	mfhi	$a0
	.end_macro
	
# START OF PROGRAM
	li	$t0, 1		# set $t0 to 1 for powers

	la 	$a0, intro	# load the label value into $a0
	print_str
	
	la 	$a0, prompt
	print_str
	
	la 	$v0, 5		# get user input
	syscall
	
	move	$a0, $v0	# store user input in $a0
	
	check (10)
	check (9)
	check (8)
	check (7)
	check (6)
	check (5)
	check (4)
	check (3)
	check (2)
	check (1)
	check (0)
	
	done