/* O codigo a seguir implementa a ordenacao pelo metodo da selecao. Neste
   metodo, em cada passo, o menor elemento eh encontrado e colocado em sua
   posicao de ordenacao. Ou seja, no primeiro passo, o menor elemento de todos
   eh colocado na primeira posicao; no segundo passo, o proximo menor elemento    eh colocado na segunda posicao; no terceiro passo, o proximo menor elemento
   eh colocado na terceira posicao e assim sucessivamente. Para encontrar
   o menor elemento de todos, inicializa uma variavel com o menor elemento e
   a compara com todos que estao a frente. Caso um elemento menor seja
   encontrado, ele passara a ser o novo menor.
*/

.section .data
	titulo:	 .asciz "\n*** Programa Ordena Vetor 1.0 ***\n\n"
	pedetam: .asciz "Digite o tamanho do vetor (maximo=20) => "
	formato: .asciz "%d"
	pedenum: .asciz "Entre com o elemento %d => "
	mostra1: .asciz "Elementos Lidos:"
	mostra2: .asciz " %d,"
	mostra3: .asciz "Elementos Ordenados:"
	pulalin: .asciz "\n"
	maxtam:  .int 30
	tam: 	 .int 0
	num:	 .int 0
	vetor: 	 .int 4
    teste:   .asciz "AOBA"

.section .text
.globl _start
_start:

	pushl 	$titulo
	call 	printf

	call 	leTam
   
	call	alocaVetor
	call	leVetor

	pushl 	$mostra1
	call 	printf
	addl 	$4, %esp
	call	mostraVetor

	call	ordenaVetor

	pushl 	$mostra3
	call 	printf
	addl 	$4, %esp
	call	mostraVetor

	jmp	fim

leTam:
	pushl 	$pedetam
	call 	printf
	pushl 	$tam
	pushl 	$formato
	call 	scanf
	pushl 	$pulalin
	call 	printf
	addl	$16, %esp

	movl 	tam, %ecx
    cmpl    $0, %ecx    
	jle 	leTam
	cmpl 	maxtam, %ecx
	jg 	leTam

	RET

alocaVetor:

	movl 	tam, %eax
	movl	$4, %ebx
	mull 	%ebx
	pushl 	%eax
	call 	malloc
	movl 	%eax, vetor
    addl    $4,%esp
	RET

leVetor:

	movl 	$0, %ebx
	movl 	tam, %ecx
    movl    vetor,%edi

_leMaisUm:
	incl 	%ebx
	pushl 	%edi
	pushl 	%ecx
	pushl 	%ebx
	pushl 	$pedenum
	call 	printf
	pushl 	$num
	pushl 	$formato
	call 	scanf
	pushl 	$pulalin
	call 	printf
	addl 	$16, %esp
	popl 	%ebx
	popl 	%ecx
	popl 	%edi
	movl 	num, %eax
    movl    %eax,(%edi)
	addl 	$4, %edi
	loop 	_leMaisUm
	RET

mostraVetor:
	movl 	tam, %ecx
	movl 	vetor, %edi

    _mostraMaisUm:
        movl 	(%edi), %ebx
        addl 	$4, %edi
        pushl 	%edi
        pushl 	%ecx
        pushl 	%ebx
        pushl 	$mostra2
        call 	printf
        addl 	$8, %esp
        popl 	%ecx
        popl 	%edi
        loop 	_mostraMaisUm
	pushl 	$pulalin
	call 	printf
	addl	$4, %esp
	RET

ordenaVetor:

	movl 	tam, %ecx
	cmpl 	$1, %ecx
	jle 	_retorna   	# nao tem oque fazer

	movl 	vetor, %edx	# %edx marca a posicao onde sera inserido
                                # o menor elemento depois de cada busca, que
		        		# inicialmente é a primeira posicao     

	decl	%ecx	        # %ecx marca a quantidade de elementos 
                                # seguintes que serao comparados com o menor	

_giroExterno:

	movl	%edx, %edi	# %edi marca a posicao onde esta o menor 
                        # elemento, que inicialmente esta na                                            
                        # mesma posicao onde sera inserido o menor

	movl	%edx, %esi	# falta 6
   
	addl	$4, %esi        # %esi marca a posicao do proximo a ser 
                            # comparado com o menor atual 

	pushl 	%ecx         	# backup de %ecx para o loop externo

_giroInterno:
	movl 	(%edi), %eax    # contem o menor valor
	movl 	(%esi), %ebx    # contem o valor do proximo

	cmpl 	%eax, %ebx	# compara o menor atual com o proximo
	jl 	_atualizaPosicaoMenor	# salta se o proximo for menor que
                                        # o menor atual

_voltaDaAtualizacao:
	addl 	$4, %esi      # avanca o proximo	# falta 7
	loop _giroInterno

_trocaElementos:
	movl 	(%edx), %ebx
	movl 	(%edi), %eax
	movl 	%eax, (%edx)
	movl 	%ebx, (%edi)

	addl 	$4, %edx     # avança a posicao de insercao do menor
			       # falta 8
	
	popl	%ecx
	loop	_giroExterno

	RET

_atualizaPosicaoMenor:
	movl 	%esi, %edi      # a posicao do proximo para a ser posicao 
                                # do menor	# falta 9
	jmp _voltaDaAtualizacao

_retorna:
	RET

fim:
	pushl $0
	call exit
