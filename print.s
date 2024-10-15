.section .text
.global print_message

// Función: print_message
// Argumentos:
//   x0: dirección del mensaje a imprimir
print_message:
    // Guardar el puntero a la cadena
    mov x1, x0          // x1 = puntero a la cadena (mensaje)

    // Calcular la longitud de la cadena
    mov x2, 0           // Inicializar contador de longitud a 0
length_loop:
    ldrb w3, [x1, x2]   // Cargar un byte de la cadena en w3
    cmp w3, #0          // Comparar el byte actual con 0 (fin de cadena)
    beq done_length     // Si es 0, hemos encontrado el final
    add x2, x2, #1      // Incrementar el contador de longitud
    b length_loop       // Volver al inicio del bucle
done_length:

    // Preparar la llamada al sistema para escribir
    mov x0, #1          // Descriptor de archivo 1 (stdout)
    mov x1, x1          // Puntero al mensaje
    mov x2, x2          // Longitud del mensaje
    mov x8, #64         // Número de llamada del sistema para sys_write
    svc #0              // Llamar al sistema

    // Retornar
    ret
