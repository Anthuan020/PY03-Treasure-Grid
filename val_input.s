.section .text
.global validate_input

// Esta función recibe un número en x0 y valida que esté entre 0 y 50
validate_input:
    cmp x0, #0               // Comparar con 0
    blt return_zero          // Si es menor que 0, retornar 0
    cmp x0, #50              // Comparar con 50
    bgt return_zero          // Si es mayor que 50, retornar 0

    mov x1, #1               // Si la validación es exitosa, retornar 1
    ret                       // Regresar

return_zero:
    mov x1, #0               // Si la validación falla, retornar 0
    ret                       // Regresar
