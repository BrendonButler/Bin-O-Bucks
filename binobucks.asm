# I, Brendon Butler, certify that this assignment is of my own work, based on my personal study.
	
	.data	# declare variables in memory
intro:	.asciiz "Greetings! I'm your robot bank teller.\n"
prompt: .asciiz "How many power-of-two dollars do you want?\n"
here:	.asciiz "Here are your $"
bob:	.asciiz " Bin-O-Bucks\n"

dollar:	.asciiz " dollar bill\n"
	
	.text	# program instructions follow .text

	# main instruction label
main: 	.macro print_int		# print integer values to the console
	li $v0, 1
	syscall
	.end_macro
	
	.macro print_str		# print string values to the console
	li $v0,	4
	syscall
	.end_macro
	
	.macro done			# end of program macro
	li $v0, 10
	syscall
	.end_macro
	
	.macro execute ($power)		# divide by powers of 2 to find denomination quantities, print out values
	#	division
	sllv	$t1, $t0, $power	# shift left by the power given, store value in $t1
	div 	$a0, $a0, $t1		# divide $a0 (quotient or original number) by $t1
	mflo	$a0			# move quotient to $a0
	print_int			# print integer in $a0
	
	#	print space char
	li 	$a0, 32 		# print whitepace as line separator
	li 	$v0, 11			# syscall for char print
	syscall
	
	#	print denomination amounts and move remaining value to $a0 for futher calculations
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
	move	$t3, $v0	# store user input in $t3
	
	li	$t2, 10 	# power to start (10 = 1024, 9 = 512, ...)
	
	la	$a0, here	# load the label value into $a0
	print_str
	la	$a0, ($t3)	# load the user input into $a0
	print_int
	la	$a0, bob	# load the label value into $a0
	print_str
	move	$a0, $t3	# store user input in $a0
	
# TODO : PRINT result banner with user input value embedded
loop:
	execute ($t2)		# run "execute" macro to shift the value left by the power $t2, divide and print
	sub	$t2, $t2, 1	# decrement the power of 2 ($t2) by 1 to find the next denomination amount
	bne 	$t2, -1, loop	# goto "loop" if $t2 is NOT -1
	
	done			# end program
	