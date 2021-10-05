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
	
	.macro check ($power)
	sllv	$t1, $t0, $power	# shift left by the power given, store value in $t1
	div 	$a0, $a0, $t1		# divide $a0 (quotient or original number) by $t1
	mflo	$a0			# move quotient to $a0
	print_int			# print integer in $a0
	
	li 	$a0, 32 		# print whitepace as line separator
	li 	$v0, 11			# syscall for char print
	syscall
	
	la	$a0, ($t1)		# print dollar bill denomination
	print_int
	la	$a0, dollar		# print dollar text
	print_str
	mfhi	$a0			# move remainder into $a0
	.end_macro
	
# START OF PROGRAM
	li	$t0, 1		# set $t0 to 1 for powers
	la 	$a0, intro	# load the label value into $a0
	print_str	
	la 	$a0, prompt	# prompt user for number between 1-2048
	print_str
	la 	$v0, 5		# get user input
	syscall
	move	$a0, $v0	# store user input in $a0
	
	li	$t2, 10 	# power to start (10 = 1024, 9 = 512, ...)
	
# TODO : PRINT result banner with user input value embedded
loop:
	check ($t2)
	sub $t2, $t2, 1
	bne $t2, -1, loop
	
	done