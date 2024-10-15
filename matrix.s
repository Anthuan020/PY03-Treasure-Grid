.section .data
.align 4

array:
    .rept 400
    .byte 0
    .endr
.text
.global setValue
// Función: set_value
// Parámetros:
//   x0 = fila (y)
//   x1 = columna (x)
//   x2 = valor a almacenar
// Efecto: Guarda el valor en array[y][x]
setValue:
    // Cargar las dimensiones de la matriz (10x10 en este ejemplo)
    mov x3, x28  // Número de columnas

    // Calcular el offset: offset = y * columnas + x
    mul x4, x0, x3  // x4 = y * 10
    add x4, x4, x1  // x4 = y * 10 + x

    // Escribir el valor en array[offset]
    ldr x5, =array  // Cargar la dirección base de 'array'
    add x5, x5, x4  // Dirección del elemento deseado
    strb w2, [x5]   // Almacenar el valor (byte) en la posición calculada

    ret  // Regresar al llamador

.global getValue
getValue:
    // x0 - dirección base de la matriz (array)
    // x1 - índice de la fila (coordenada Y)
    // x2 - índice de la columna (coordenada X)
    // retorno: w0 = valor de la celda en la posición (x1, x2)

    // Verificar límites para la fila y la columna
    cmp x1, #20            // Cambia a 10 si tu matriz es de 10x10
    bge exit               // Salir si x1 es mayor o igual que 20
    cmp x2, #20            // Cambia a 10 si tu matriz es de 10x10
    bge exit               // Salir si x2 es mayor o igual que 20

    // Calcular la dirección de la celda
    lsl x3, x1, #2        // Multiplicar la fila por el tamaño de la fila (4 bytes por elemento)
    add x3, x3, x2        // Sumar la columna para obtener el índice lineal
    add x0, x0, x3        // Calcular la dirección de la celda

    ldrb w0, [x0]         // Cargar el valor de la celda
    ret

exit:
    mov w0, #0             // Valor por defecto en caso de salir
    ret
