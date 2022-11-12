.section .data
    output: .ascii "O fabricante 'xxxxxxxxxxxxx' foi identificado \n"
    output2: .ascii "###############"


.section .text

.globl _start
_start:
    movl $0, %eax
    cpuid
    movl $output, %edi
    movl %ebx, 15(%edi) 
    movl %edx, 19(%edi)
    movl %ecx, 23(%edi)
    movl $4, %eax
    movl $1, %ebx
    movl $output, %ecx
    movl $60, %edx
    int $0x80
    movl $1, %eax 
    movl $0, %ebx 
    int $0x80 