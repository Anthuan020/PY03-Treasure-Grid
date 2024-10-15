.section .data
char:   .ascii "▒"  // Definición del carácter por defecto
char2:	.ascii "■" //Definicion del caracter con tesoro
char3:	.ascii "┼" //Definicion del caracter sin tesoro
char4:	.asciz "X" //Tesoro oculto
char5:	.asciz "*" //Hot

newline: .ascii "\n" // Nueva línea


//Recibe filasXcolumnas en x0
.section .text
.global print_matrix_fn
print_matrix_fn:
    mov x7, x0              // Cargar la cantidad de filas/columnas en x7
    mov x5, #0              // Inicializar el índice de filas (0)

for_x:
    cmp x5, x7              // Comparar el índice de filas con el total
    beq for_done            // Si son iguales, finalizar

    mov x6, #0              // Inicializar el índice de columnas (0)

for_y:
    cmp x6, x7              // Comparar el índice de columnas con el total
    beq for_newline         // Si son iguales, imprimir nueva línea

	b validacion

print_char:
    mov x0, 1
    ldr x1, =char
    mov x2, 3              // Longitud del carácter
    mov x8, 64              // Código del servicio para escribir
    svc 0                   // Llamar al servicio
    b skip_print
print_char2:
    mov x0, 1
    ldr x1, =char2
    mov x2, 3
    mov x8, 64
    svc 0
    b skip_print
print_char3:
    mov x0, 1
    ldr x1, =char3
    mov x2, 3
    mov x8, 64
    svc 0
    b skip_print
print_char4:
    mov x0, 1
    ldr x1, =char4
    mov x2, 1
    mov x8, 64
    svc 0
    b skip_print
print_char5:
    mov x0, 1
    ldr x1, =char5
    mov x2, 1
    mov x8, 64
    svc 0
    b skip_print

skip_print:
	add x6, x6, 1
	b for_y

for_newline:
    mov x0, 1               // Código de salida para imprimir
    ldr x1, =newline        // Cargar la dirección de nueva línea
    mov x2, #1              // Longitud de la nueva línea
    mov x8, 64              // Código del servicio para escribir
    svc 0                   // Llamar al servicio

    add x5, x5, 1           // Incrementar el índice de filas
    b for_x                 // Repetir el bucle para las filas

for_done:

	ret

validacion:
	ldr x0, =array
	mov x1, 0
	mul x1, x5, x7
	add x1, x1, x6
	add x0, x0, x1
	ldrb w0, [x0]

	cmp w0, #0
	beq print_char

	cmp w0, #1
	beq print_char2

	cmp w0, #2
	beq print_char3

	cmp w0, #3
	beq print_char

	cmp w0, #4
	beq print_char
	b skip_print
