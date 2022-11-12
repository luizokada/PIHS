.section .data
    pedido1: .asciz "\nTeste %d: Digite um caractere => "
    mostra1: .asciz "\nTeste %d: Caractere digitado = %c\n"
    tecla: .int 'A'
    pedido2: .asciz "\nTeste %d: Digite um numero inteiro => "
    mostra2: .asciz "\nTeste %d: Numero digitado = %d\n"
    numero: .int 0
    pedido3: .asciz "\nTeste %d: Digite uma palavra nao composta => "
    mostra3: .asciz "\nTeste %d: Palavra digitada = %s\n"
    frase: .space 64
    pedido4_1: .asciz "\nTeste %d: Digite 2 numeros inteiros:\n N1 = "
    pedido4_2: .asciz "\n N2 = "
    mostra4_1: .asciz "\nTeste %d: Numeros lidos: n1 = %d e n2 = %d\n"
    mostra4_2: .asciz "\nTeste %d: n1 igual a n2\n"
    mostra4_3: .asciz "\nTeste %d: n2 menor que n1\n"
    mostra4_4: .asciz "\nTeste %d: n2 maior que n1\n"
    mostra4_5: .asciz "\nTeste %d: Acabou as comparacoes!\n"
    n1: .int 0
    n2: .int 0
    pedido5: .asciz "\nTeste %d: Quantos giros quer no loop? "
    mostra5_1: .asciz "\nTeste %d: Girando %d...\n"
    mostra5_2: .asciz "\nTeste %d: Acabou o loop!\n\n"
    ngiros: .int 0
    pedido6: .asciz "\nTeste %d: Digite uma frase composta => "
    mostra6: .asciz "\nTeste %d: Frase digitada = %s\n"
    tipocar: .asciz "%c"
    tipocar2: .asciz " %c" #despreza o <enter> e pega o próximo
    tiponum: .asciz "%d"
    tipostr: .asciz "%s"
.section .text
.globl _start
_start:
    teste1:
    pushl $1
    pushl $pedido1
    call printf
    pushl $tecla
    pushl $tipocar
    call scanf
    pushl tecla
    pushl $1
    pushl $mostra1
    call printf
    teste2:
    pushl $2
    pushl $pedido2
    call printf
    pushl $numero
    pushl $tiponum
    call scanf
    pushl numero
    pushl $2
    pushl $mostra2
    call printf
    teste3:
    pushl $3
    pushl $pedido3
    call printf
    pushl $frase
    pushl $tipostr
    call scanf
    pushl $frase
    pushl $3
    pushl $mostra3
    call printf
    teste4:
    pushl $4
    pushl $pedido2
    call printf
    pushl $numero
    pushl $tiponum
    call scanf
    pushl numero
    pushl $4
    pushl $mostra2
    call printf
    pushl $4
    pushl $pedido1
    call printf
    pushl $tecla
    pushl $tipocar
    call scanf
    pushl tecla
    pushl $4
    pushl $mostra1
    call printf
    pushl $4
    pushl $pedido3
    call printf
    pushl $frase
    pushl $tipostr
    call scanf
    pushl $frase
    pushl $4
    pushl $mostra3
    call printf
    pushl $4
    pushl $pedido1
    call printf
    pushl $tecla
    pushl $tipocar
    call scanf
    pushl tecla
    pushl $4
    pushl $mostra1
    call printf
    teste5:
    pushl $5
    pushl $pedido2
    call printf
    pushl $numero
    pushl $tiponum
    call scanf
    pushl numero
    pushl $5
    pushl $mostra2
    call printf
    pushl $5
    pushl $pedido1
    call printf
    pushl $tecla
    pushl $tipocar2
    call scanf
    pushl tecla
    pushl $5
    pushl $mostra1
    call printf
    pushl $5
    pushl $pedido3
    call printf
    pushl $frase
    pushl $tipostr
    call scanf
    pushl $frase
    pushl $5
    pushl $mostra3
    call printf
    pushl $5
    pushl $pedido1
    call printf
    pushl $tecla
    pushl $tipocar2
    call scanf
    pushl tecla
    pushl $5
    pushl $mostra1
    call printf
    teste6:
    pushl $6
    pushl $pedido4_1
    call printf
    pushl $n1
    pushl $tiponum
    call scanf
    pushl $6
    pushl $pedido4_2
    call printf
    pushl $n2
    pushl $tiponum
    call scanf
    pushl n2
    pushl n1
    pushl $6
    pushl $mostra4_1
    call printf
    movl n2, %ebx # %eax e %ecx são alterados no printf. %ebx não.
    cmpl n1, %ebx
    je saoiguais # aqui tambem serve o jz
    jl n2menorn1
    jmp n1menorn2
    saoiguais:
    pushl $6
    pushl $mostra4_2
    call printf
    jmp fim
    n2menorn1:
    pushl $6
    pushl $mostra4_3
    call printf
    jmp fim
    n1menorn2:
    pushl $6
    pushl $mostra4_4
    call printf
    jmp fim
    fim:
    pushl $6
    push $mostra4_5
    call printf
    teste7:
    pushl $7
    pushl $pedido5
    call printf
    pushl $ngiros
    pushl $tiponum
    call scanf
    movl ngiros, %ecx
    volta2:
    movl %ecx, %ebx # backup de %ecx, pois ele eh alterado no printf
    pushl %ecx
    pushl $7
    pushl $mostra5_1
    call printf
    movl %ebx, %ecx
    loop volta2
    pushl $7
    pushl $mostra5_2
    call printf
    teste8:
    pushl $8
    pushl $pedido6
    call printf
    pushl $frase
    call gets # para retirar o <enter> do buffer do teclado
    call gets # para ler efetivamente uma string composta
    pushl $8
    pushl $mostra6 # $frase já estava no topo da pilha qdo gets foi chamada
    call printf
    teste9:
    pushl $9
    pushl $pedido6
    call printf
    pushl stdin # para maquina remota. Para conexão local pode usar “pushl $0”
    pushl $64
    pushl $frase
    call fgets
    pushl $9
    pushl $mostra6
    call printf
    pushl $0
    call exit