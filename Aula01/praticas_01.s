.section .data
x: .int 10
y: .int 5
z: .int -1

.section .text
.globl _start
_start:
movl x, %eax
_passo1:
movl $x, %ebx
_passo2:
movl %eax, y
_passo3:
movl %ebx, y
_passo4:
addl %eax, %ebx
_passo5:
addl %ebx, %eax
_fim:
movl $1, %eax
movl $0, %ebx
int $0x80