.data
	welcome_msg: .asciz "Welcome to the Treasure Grid! \n"
	attempts_msg: .asciz "Select the number of the attempts: "
	treasures_msg: .asciz "Select the number of the treasures: "
	size_msg: .asciz "Select the size of the map (10/20): "
	coord_y_msg: .asciz "Select the coordinate Y: "
	coord_x_msg: .asciz "Select the coordinate X: "
	error_coords_msg: .asciz "\n\nThe coordinates cannot be larger than the size of the map\n\n"

	found_treasure: .asciz "\n\ncongratulations you found a treasure!\n\n"
	no_found_treasure: .asciz "\n\nThere is nothing here and there are no treasures nearby, look carefully\n\n"
	revised_incorrect_msg: .asciz "\n\nThere's nothing here, searching again won't make anything appear... -_-\n\n"
	revised_correct_msg: .asciz "\n\nYou already found something here, stop being greedy and look elsewhere.\n\n"
	hot_msg: .asciz "\n\nIs it me or is it hot in here? or should I say... there is a treasure nearby\n\n"

	win_msg: .asciz "\n\n\nCongratulations! You won the game!\n\n\n"
	lose_msg: .asciz "\n\nUnfortunately you didn't find all the treasures, I expected more from you :c\n\n"

	play_again_q: .asciz "\n\n\n\nWould you like to play again?\n\n"
	pa_option1:	.asciz "1.Yes\n"
	pa_option2:	.asciz "2.No\n"
	pa_error:	.asciz "Invalid answer!!"
	pa_get_into:	.asciz "Here's the answer bro: "
.text
.global _start
.include "print.s"
.include "input_int.s"
.include "matrix.s"
.include "print_matrix.s"
.include "random.s"
.include "reset.s"
_start:
/*
	IMPORTANTE!!

	No se debe usar como variables los registros 28,27,26
	x28 Almacena the size of the map
	x27 Almacena la cantidad de tesoros
	x26 Almacena la cantidad de intentos
*/
	ldr x0, =array
	bl reset_array

	ldr x0, =welcome_msg
	bl print_message

	ldr x0, =attempts_msg
	bl print_message
	bl input
	mov x26, x0

	ldr x0, =treasures_msg
	bl print_message
	bl input
	mov x27, x0

	ldr x0, =size_msg
	bl print_message
	bl input
	mov x28, x0
//pruebas
treasure_allocation:
	mov x9, x27

loop_treasure:
	cmp x9, 0
	beq map_printed

	mov x0, 0
	sub x0, x28, 1
	bl numeroAleatorio
	mov x21, x0
	mov x0, 0
	sub x0, x28, 1
	bl numeroAleatorio
	mov x22, x0

	// Validación para verificar si ya hay un tesoro en la posición
	ldr x0, =array
	mov x1, x21
	mov x2, x22
	bl getValue    // Obtener el valor actual en la posición

	cmp w0, #3      // Comparar con el valor que representa un tesoro
	beq loop_treasure // Si ya hay un tesoro, volver a intentar

	cmp w0, #4
	beq loop_treasure
	// Si no hay tesoro, continuar con la asignación
	mov x0, x21
	mov x1, x22
	mov x2, #3     // Valor para el tesoro
	bl setValue

N1_N1: //(-Y,-X)
        mov x0, x21
        sub x0, x0, 1
        mov x1, x22
        sub x1, x1, 1

        //Validaciones
        mov x3, 0
        sub x3, x28, 1

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
	b loop_treasure



map_printed:
	cmp x27, 0
	beq win_check

	cmp x26, 0
	beq lose_check

	mov x0, x28
	bl print_matrix_fn

coords_select:
	ldr x0, =coord_y_msg
	bl print_message
	bl input

	cmp x0, #0
	blt error_coords

	mov x25, #0
	sub x25, x28, #1
	cmp x0, x25
	bgt error_coords

	mov x21, x0

	ldr x0, =coord_x_msg
	bl print_message
	bl input

	cmp x0, #0
	blt error_coords

	mov x25, #0
	sub x25, x28, #1
	cmp x0, x25
	bgt error_coords

	mov x22, x0
play:
	b play_check

end_game:
    mov x0, #0                 // Código de salida
    mov x8, #93                // Número de llamada del sistema para exit
    svc #0                     // Llamar al sistema

error_coords:
	ldr x0, =error_coords_msg
	bl print_message

	b map_printed

play_check:

	ldr x0, =array
	mov x1, x21
	mov x2, x22
	bl getValue

	cmp w0, #3
	beq treasure_correct

	cmp w0, #4
	beq treasure_hot

	cmp w0, #0
	beq treasure_incorrect

	cmp w0, #1
	beq treasure_revised_correct

	cmp w0, #2
	beq treasure_revised_incorrect

treasure_correct:

	mov x0, x21
	mov x1, x22
	mov x2, #1
	bl setValue

	ldr x0, =newline
	bl print_message

	ldr x0,=found_treasure
	bl print_message

	sub x27, x27, 1

	b map_printed
treasure_hot:

	mov x0, x21
	mov x1, x22
	mov x2, #2
	bl setValue

	ldr x0, =newline
	bl print_message

	ldr x0,=hot_msg
	bl print_message

	sub x26, x26, 1

	b map_printed
treasure_incorrect:

	mov x0, x21
	mov x1, x22
	mov x2, #2
	bl setValue

	ldr x0, =newline
	bl print_message

	ldr x0,=no_found_treasure
	bl print_message

	sub x26, x26, 1

	b map_printed
treasure_revised_incorrect:
	ldr x0, =newline
	bl print_message

	ldr x0,=revised_incorrect_msg
	bl print_message

	b map_printed
treasure_revised_correct:
	ldr x0, =newline
	bl print_message

	ldr x0,=revised_correct_msg
	bl print_message

	b map_printed

lose_check:

	ldr x0, =lose_msg
	bl print_message
	b play_again
win_check:

	ldr x0, =win_msg
	bl print_message
	b play_again

play_again:
	ldr x0, =play_again_q
	bl print_message

	ldr x0, =pa_option1
	bl print_message

	ldr x0, =pa_option2
	bl print_message

	ldr x0, =pa_get_into
	bl print_message

	bl input

	cmp x0, 1
	beq _start

	cmp x0, 2
	beq end_game

	ldr x0, =pa_error
	bl print_message

	b play_again
