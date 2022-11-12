.section .data

    saida: .asciz "Resultado de: %d + %d - %d + %d - %d = %d\n"

    n1: .int 30

    n2: .int 96

    n3: .int 20

    n4: .int 5

    n5: .int 10

    v1: .int 30, 96, 20, 5, 10

.section .bss

    .lcomm res, 4

.section .text

.globl _start
_start:
    movl n1, %eax
    addl n2, %eax
    subl n3, %eax
    addl n4, %eax
    subl n5, %eax
    movl %eax, res 
    pushl res
    pushl n5
    pushl n4
    pushl n3
    pushl n2
    push n1
    pushl $saida
    call printf
    addl $20, %esp
    movl $v1, %edi
    movl (%edi), %eax
    addl $4, %edi
    addl (%edi), %eax
    addl $4, %edi
    subl (%edi), %eax
    movl %eax, res
    addl $4, %edi
    addl (%edi), %eax
    movl %eax, res
    addl $4, %edi
    subl (%edi), %eax
    movl %eax, res
    pushl res
    pushl n5
    pushl n4
    pushl n3
    pushl n2
    pushl n1
    pushl $saida
    call printf
    pushl $0
    call exit