.section .data

	abertura:	.asciz	"PROGRAMA BUSCA ELEMENTO EM VETOR\n"

	pedeNElem:	.asciz	"Digite o numero de elementos do vetor => "

	pedeElem:	.asciz	"Digite o elemento %d => "


	pedeX:		.asciz	"Digite o elemento a ser buscado => "

	mostraVetor:	.asciz	"Vetor Lido: "

	mostraElem:	.asciz	"Elemento %d localizado na posicao %d\n"

	msgInexiste:	.asciz	"Elemento Inexistente!\n"

	msgReexecucao:	.asciz	"Deseja Reexecutar <1>Sim <2>Nao? "

	nElem:		.int	0
	elem:		.int	0
	X:		    .int	0
	resp:		.int	0
    posicao:    .int    0

	tipoNum:	.asciz	"%d"

	mostraNum:	.asciz	"%d, "

	vetor:		.space	200

	pulaLinha:	.asciz	"\n"


	

.section .text

.globl _start

_start:

	pushl	$abertura
	call	printf

	call	leNElem
	call	leVetor
	call	mostraVet
	call	leX
	call	buscaX
	call	mostraRes

_fim:

	pushl 	$0
	call	exit

leNElem:

	pushl	$pedeNElem
	call	printf

	pushl	$nElem
	pushl	$tipoNum
	call	scanf

	addl	$12, %esp

	movl	nElem, %eax
	cmpl	$0, %eax
	jle	leNElem

	cmpl	$50, %eax
	jg	leNElem
	RET

leVetor:

	movl	$vetor, %edi
	movl	$1, %ebx
	movl	nElem, %ecx

_leMaisUm:

	pushl	%ecx
	pushl	%edi
	pushl	%ebx
	pushl	$pedeElem
	call	printf

	pushl	%edi
	pushl	$tipoNum
	call	scanf

	addl	$12, %esp
	
	popl	%ebx
	popl	%edi
	popl	%ecx

	incl	%ebx
	addl	$4, %edi

	loop	_leMaisUm

	RET

mostraVet:


	movl	$vetor, %edi
	movl	nElem, %ecx

_mostraMaisUm:

	pushl	%ecx
	pushl	%edi

	pushl	$mostraVetor
	call	printf
	addl	$4, %esp
	
	popl	%edi
	popl	%ecx
	
_volta1:

	pushl	%ecx
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$mostraNum
	call	printf
	
	addl	$8, %esp

	popl	%edi
	popl	%ecx

	addl	$4, %edi

	loop	_volta1

	pushl	$pulaLinha
	call	printf
	addl	$4, %esp

	RET
leX:

    pushl	$pedeX
	call	printf

	pushl	$X
	pushl	$tipoNum
	call	scanf
    addl	$12, %esp


	RET

buscaX:
    movl	$vetor, %edi
	movl	$1, %ebx
	movl	nElem, %ecx
    movl    X, %eax
	_leMaisUmElem:
		cmpl %eax,(%edi)
		je  _fimFunTrue
		addl $4,%edi
		addl $1,%ebx
		cmpl %ecx,%ebx
		jl _leMaisUmElem
		_fimFunFalse:
			movl $0, resp
			RET
		_fimFunTrue:
			movl %ebx,posicao
			movl $1, resp
			RET

mostraRes:
    movl resp, %ecx
    cmpl $1,%ecx
    je _respTrue
    _respFalse:
    push msgInexiste
    call printf
    addl	$4, %esp
    RET
    _respTrue:
    pushl   posicao
    pushl   X
    pushl	$mostraElem
	call	printf
    addl	$12, %esp
	RET	
	

