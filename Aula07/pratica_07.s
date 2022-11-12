.section .data

	abert:	.asciz	"\nPrograma para Ordenar 3 Numeros\n\n\n"
	pedeN:	.asciz	"\nDigite N%d => "
	tipoN:	.asciz	"%d"

	mostra:	.asciz	"\nNumeros Ordenados: %d, %d, %d\n\n"

	perg:	.asciz	"\nDeseja nova ordenacao <S>im/<N>ao? " 

	tipoC:	.asciz	" %c"	# o espaço remove <tab>s e <enter>s
				# antes do caractere a ser lido

	n1:	.int	0
	n2:	.int	0
	n3:	.int	0
    n4:	.int	0
    v1: .int    0,0,0,0

	resp:	.byte	'n'
	

.section .text
.globl _start

_start:

	pushl	$abert
	call	printf

	pushl	$1
	pushl	$pedeN
	call	printf
	pushl	$n1
	pushl	$tipoN
	call	scanf

	pushl	$2
	pushl	$pedeN
	call	printf
	pushl	$n2
	pushl	$tipoN
	call	scanf

	pushl	$3
	pushl	$pedeN
	call	printf
	pushl	$n3
	pushl	$tipoN
	call	scanf


	pushl	$4
	pushl	$pedeN
	call	printf
	pushl	$n4
	pushl	$tipoN
	call	scanf

	movl $v1, %edi
    movl (%edi), n1
    addl $4, %edi
    movl (%edi), n2
    addl $4, %edi
    movl (%edi), n3
    addl $4, %edi
    movl (%edi), n4
    addl $4, %edi

    movl $v1, %edi



fim:	
	pushl	$mostra
	call	printf

	addl	$16, %esp

	pushl	$perg
	call	printf

	pushl	$resp
	pushl	$tipoC
	call	scanf

	movb	resp, %al
	cmpb	$'s',%al
	je	_start

	pushl	$0
	call	exit