

.section .data
	titulo:  .asciz "\n*** Ordenacao de Vetor por Bubble Sort ***\n\n"
	pedetam: .asciz "Digite o tamanho do vetor (maximo=20) => "
	formato: .asciz "%d"
	pedenum: .asciz "Entre com o elemento %d => "
	mostra1: .asciz "Elementos Lidos:"
	teste: .asciz "ME MATA\n"
	mostra2: .asciz " %d"
	mostra3: .asciz "\nElementos Ordenados:"
	menuOp:		.asciz	"Menu de Opcoes\n<1> Ler Vetor\n<2> Ordenar por Bubble\n<3> Ordenar por Selection\n<4> Finalizar\nDigite opcao => "
	pulalin: .asciz "\n"
	maxtam:  .int 20
	tam:     .int 0	    # tamanho original do vetor em numero de elementos
	tamaux:  .int 0	    # tamanho auxiliar, que reduz na medida em que o 
                            # vetor vai sendo ordenado
	opcao:   .int 0
	num:     .int 0
	soma:    .int 0
	ultroca: .int 0	    # indice da ultima troca
        indice:  .int 0     # indice do elemento atual 

	vetor:  .space 80
	vetorCopia: .space 80
	
.section .text
.globl _start
_start:

	pushl $titulo
	call printf
	
	call resolveOpcoes



resolveOpcoes:
    pushl   $menuOp
	call    printf
    pushl	$opcao
	pushl	$formato
	call	scanf

	addl	$12, %esp

	cmpl	$1, opcao
	je	_leVetor

	cmpl	$2, opcao
	je	_ordenaVetoreBubble
	
	cmpl	$3, opcao
	je	_ordenaVetoreSelection

	cmpl	$4, opcao
	je	fim

	RET

	_leVetor:
	call letam
	movl $vetor, %edi
	call mostravet

	pushl $pulalin
	call printf
	addl $4,%esp
	
	jmp resolveOpcoes
	
	_ordenaVetoreBubble:
	call copiaVetor
	movl $vetorCopia, %edi
	call mostravet
	movl tam, %ecx
	call ordenaVetorBubble
	pushl $pulalin
	call printf
	addl $4,%esp
	call mostravet2
	jmp resolveOpcoes

	_ordenaVetoreSelection:
	call copiaVetor
	movl $vetorCopia, %edi
	call mostravet
	movl tam, %ecx
	call ordenaVetorSelection
	pushl $pulalin
	call printf
	addl $4,%esp
	call mostravet2
	jmp resolveOpcoes


letam:
	pushl $pedetam
	call printf
	pushl $tam
	pushl $formato
	call scanf
	pushl $pulalin
	call printf
	movl tam, %ecx
	movl %ecx, tamaux # copia auxiliar do tamanho
	cmpl $0, %ecx
	jle letam
	cmpl maxtam, %ecx
	jg letam
	movl $vetor,%edi
	addl $16, %esp
	movl $0, %ebx

	lenum:
		incl %ebx
		pushl %edi
		pushl %ecx
		pushl %ebx
		pushl $pedenum
		call printf
		pushl $num
		pushl $formato
		call scanf
		pushl $pulalin
		call printf
		addl $16, %esp
		popl %ebx
		popl %ecx
		popl %edi
		movl num, %eax
		movl %eax, (%edi)
		addl $4, %edi
		loop lenum
	RET

mostravet:
	pushl $mostra1
	call printf
	addl $4, %esp
	movl tam, %ecx
	_mostranum:
		movl (%edi), %ebx
		addl $4, %edi
		pushl %edi
		pushl %ecx
		pushl %ebx
		pushl $mostra2
		call printf
		addl $8, %esp
		popl %ecx
		popl %edi
		loop _mostranum    # nao tem mais oque fazer

	pushl $pulalin
	call printf
	addl $4,%esp
	RET


	
copiaVetor:
        movl tam, %ecx
		movl $vetor, %edi
		movl $vetorCopia, %esi
		_copianum:
			movl (%edi), %ebx
			movl %ebx, (%esi)
			addl $4, %edi
			addl $4, %esi
			loop _copianum  
	RET




ordenaVetorBubble:
	
	movl $vetorCopia, %edi  # %edi inicia a posicao do primeiro
	movl %edi, %esi
	addl $4, %esi      # %esi inicia a posicao do vizinho a direita (proximo)
	movl $1, ultroca   # ultroca mantem o indice da ultima troca 
	movl $1, indice    # indice mantem o indice do elemento atual
	subl $1, %ecx
	giro:
		movl (%edi), %eax  # %eax contem o valor da posicao atual (maior)
		movl (%esi), %ebx  # %bx contem o valor do vizinho da direita (proximo)
		cmpl %eax, %ebx
		jl trocaelemento

	avanca:
		addl $4, %edi      # avanca a posicao atual 
		addl $4, %esi      # avanca o proximo vizinho
		incl indice	   # avanca o indice do elemento atual
		loop giro
		
	proximociclo:
		movl ultroca, %eax
		movl %eax, tamaux  # decrementa o tamanho do vetor
		movl %eax, %ecx

		cmpl $1, %ecx
		jle _fimBublle     # nao tem mais oque fazer
		jmp ordenaVetorBubble

	trocaelemento:
		movl indice, %edx
		movl %edx, ultroca
		movl %eax, (%esi) # troca valores entre os vizinhos
		movl %ebx, (%edi) # colocando o maior no vizinho da direita
		jmp avanca
	_fimBublle:
		RET



mostravet2:
		pushl $mostra3
		call printf
		addl $4, %esp
		movl tam, %ecx
		movl $vetorCopia, %edi

	_mostranum2:
		movl (%edi), %ebx
		addl $4, %edi
		pushl %edi
		pushl %ecx
		pushl %ebx
		pushl $mostra2
		call printf
		addl $8, %esp
		popl %ecx
		popl %edi
		loop _mostranum2
		pushl $pulalin
		call printf
		pushl $pulalin
		call printf
		addl $8, %esp
	RET
fim:
	pushl $0
	call exit

ordenaVetorSelection:

	movl 	tam, %ecx
	cmpl 	$1, %ecx
	jle 	_retorna   	# nao tem oque fazer

	movl 	$vetorCopia, %edx	# %edx marca a posicao onde sera inserido
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

