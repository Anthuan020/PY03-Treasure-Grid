.global reset_array
reset_array:
    // x0: dirección base del array (array)
    // x1: tamaño del array (400 para un array de 400 bytes)

    mov x1, #400                // Establecer el tamaño del array a 400 bytes
    mov x2, #0                  // Valor a asignar (0)
    
reset_loop:
    // Almacenar 0 en la posición actual del array
    strb w2, [x0], #1           // Escribir 0 y avanzar al siguiente byte
    subs x1, x1, #1             // Decrementar el contador
    bne reset_loop              // Repetir hasta que x1 sea 0

    ret
