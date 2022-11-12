.section .data
    abertura: .asciz "\nPrograma para Somar 3 Numeros\n"
    saida: .asciz "Soma: %d + %d = %d\n"
    peden1: .asciz "\nEntre com o valor de n = "
    formato: .asciz "%d" # usado pelo scanf para saber o tipo do dado
# a ser lido
    n1: .int 0
    
    res: .int 0
.section .text
.globl _start
_start:
    pushl $peden1 # empilha mensagem com o endereço da mensagem de pedido
    call printf # e chama o printf para imprimir a mensagem
    pushl $n1 # empilha o endereço da variável
    pushl $formato # empilha o formato do dado a ser lido
    call scanf # chama scanf para faze a leitura na variáve
    movw 