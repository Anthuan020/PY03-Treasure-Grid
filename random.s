.section .text
.global numeroAleatorio

numeroAleatorio:
    // x28 contiene el límite superior

.loop:
    // Leer el contador de ciclos del temporizador
    mrs x1, CNTVCT_EL0          // Cargar el valor del contador de ciclos en x1

    // Utilizar el contador como semilla
    lsr x2, x1, 4               // Desplazar a la derecha para reducir la entropía
    eor x2, x2, x0              // XOR con el límite para variar el número

    // Asegúrate de que el número esté en el rango [0, x28 - 1]
    and x0, x2, x28             // x0 = número aleatorio en el rango [0, x28 - 1]

    // Verificar que x0 sea positivo (debería ser siempre >= 0)
    cmp x0, #0
    blt .loop                   // Si x0 < 0, repetir el proceso

    cmp x0, x28
    bge .loop
    ret                         // Retornar el número aleatorio en x0
