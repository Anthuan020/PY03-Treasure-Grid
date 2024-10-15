.text
.global treasures_generate
treasures_generate:

	mov x9, x27

loop_treasures:
	cmp x9, 0
	beq loop_treasures_done

	mov x0, 0
	sub x0, x27, 1
	mov x0, 5 //random
	mov x21, x0
	mov x0, 0
	sub x0, x27, 1
	mov x0, 5 //random
	mov x22, x0

	mov x0, 5
	mov x1, 5
	mov x2, #3
	//setValue

	mov x3, x28

	mul x4, x0, x3
	add x4, x4, x1

	ldr x5, =array
	add x5, x5, x4

	strb w2, [x5]

	mov x9, 0
	b loop_treasures

N1_N1: //(-Y,-X)
	mov x0, x21
	sub x0, x0, 1
	mov x1, x22
	sub x1, x1, 1

	//Validaciones
	mov x3, 0
	sub x3, x27, 1

	cmp x0, #0
	blt N1_0

	cmp x0, x3
	bgt N1_0

	cmp x1, #0
	blt N1_0

	cmp x1, x3
	bgt N1_0
	mov x2, #4 //Hot
	bl setValue
N1_0:
	mov x0, x21
	sub x0, x0, 1
	mov x1, x22

	//Validaciones
	cmp x0, #0
	blt N1_P1

	cmp x0, x3
	bgt N1_P1

	cmp x1, #0
	blt N1_P1

	cmp x1, x3
	bgt N1_P1

	mov x2, #4
	bl setValue
N1_P1:
	mov x0, x21
	sub x0, x0, 1
	mov x1, x22
	add x1, x1, 1
	//Validaciones
	cmp x0, #0
	blt M0_N1

	cmp x0, x3
	bgt M0_N1

	cmp x1, #0
	blt M0_N1

	cmp x1, x3
	bgt M0_N1

	mov x2, #4
	bl setValue
M0_N1:
	mov x0, x21
	mov x1, x22
	sub x1, x1, 1
	//Validaciones
	cmp x0, #0
	blt M0_P1

	cmp x0, x3
	bgt M0_P1

	cmp x1, #0
	blt M0_P1

	cmp x1, x3
	bgt M0_P1

	mov x2, #4
	bl setValue
M0_P1:
	mov x0, x21
	mov x1, x22
	add x1, x1, 1
	//Validaciones
	cmp x0, #0
	blt P1_N1

	cmp x0, x3
	bgt P1_N1

	cmp x1, #0
	blt P1_N1

	cmp x1, x3
	bgt P1_N1

	mov x2, #4
	bl setValue
P1_N1:
	mov x0, x21
	add x0, x0, 1
	mov x1, x22
	sub x1, x1, 1
	//Validaciones
	cmp x0, #0
	blt P1_0

	cmp x0, x3
	bgt P1_0

	cmp x1, #0
	blt P1_0

	cmp x1, x3
	bgt P1_0

	mov x2, #4
	bl setValue
P1_0:
	mov x0, x21
	add x0, x0, 1
	mov x1, x22

	//Validaciones
	cmp x0, #0
	blt P1_P1

	cmp x0, x3
	bgt P1_P1

	cmp x1, #0
	blt P1_P1

	cmp x1, x3
	bgt P1_P1

	mov x2, #4
	bl setValue
P1_P1:
	mov x0, x21
	add x0, x0, 1
	mov x1, x22
	add x1, x1, 1
	//Validaciones
	cmp x0, #0
	blt finally_hot

	cmp x0, x3
	bgt finally_hot

	cmp x1, #0
	blt finally_hot

	cmp x1, x3
	bgt finally_hot

	mov x2, #4
	bl setValue

finally_hot:
	sub x9, x9, 1


loop_treasures_done:
	ret
