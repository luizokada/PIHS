/*

AULA PRATICA

O objetivo do programa eh implementar o algoritmo de ordenação Bubble
Sort. Nesse metodo, o algoritmo caminha no vetor desordenado, da esquerda para direita, elemento a elemento, comparando cada elemento com o seu vizinho da direita (proximo). Se o elemento proximo for menor que o elemento corrente,
troca-os de posicao e continua comparando o restante do vetor. Faz isso em todo o vetor desordenado e dessa forma, o maior elemento vai parar na ultima posicao. O elemento da ultima posicao fica na posicao correta de ordenacao. Completa-se entao 1 ciclo. Diminui o tamanho do vetor de 1, para desconsiderar o ultimo elemento que já esta na posicao correta e repete mais um ciclo de operacao com a parte do vetor que ainda está desordenada, completando o segundo ciclo. Repete sucessivamente ateh que a parte do vetor desordenada se reduza a 1 unico elemento (tamanho = 1). Observe que a cada ciclo, o maior elemento é empurrado para o final da parte desordenada do vetor. Nesta técnica de ordenação, se a partir de determinada posicao não ocorrer mais troca, isto significa que a partir da posicao da ultima troca, pra frente, o vetor ja estara ordenado corretamente e o tananho do vetor devera reduzir nao somente 1 posicao, mas para o tamanho do vetor ate a ultima troca. Se precisar relembrar o metodo, leia sobre ele. 

*/

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

/*

DESAFIO: Retire o metodo de ordenação Bubble deste programa e insire-o
 como uma funcao no programa que tem o metodo de ordenacao por Selecao, visto na aula passada. 
 Faca um menu de opcoes para o usuario escolher o que deseja fazer (ler vetor, mostra vetor original, mostra vetor ordenado, 
 ordenar por Selecao, ordenar por Bubble, finalizar).
  O programa deve ficar em loop permanente no menu de opcoes ateh que seja escolhida a opcao de finalizacao. 
  Observe que o vetor original deve ser preservado sem alteracao e a ordenacao deve ser feita em uma copia. 
  A mostragem do vetor ordenado mostrara a ultima ordenacao realizada e deve ser feita por uma mesma função, 
  mas no video deve aparecer o nome do metodo utilizado na ordenacao.

*/