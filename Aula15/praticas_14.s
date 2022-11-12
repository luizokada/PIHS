/*

Vamos supor um registro (record ou struct) com os seguintes campos:

Nome: 60 caracteres + final de string ('\0') (= 64 bytes)
Gênero (sexo): 1 caractere 'M' ou 'F' (= 4 bytes)
CPF: 11 caracteres + 3 caracteres especiais + '\0' (16 bytes)
Data de Nascimento: dia, mes e ano (3 inteiros = 12 bytes)
Idade: (1 inteiro = 4 bytes)

Total = 64+4+16+12+4 = 100 bytes

Obs: Para um alinhamento adequado de memória, cada campo deve ter uma
quantidade de bytes que seja multiplo de 4 bytes, pois o acesso em
arquiteturas de 32bits eh feito de 4 em 4 bytes.

O codigo a seguir faz a leitura e escrito deste registro.

Monte, ligue e execute o programa. Rode no GBD. Analise seu funcionamento.

Depois, faça o desafio.

*/

.section .data
	txtAbertura: 	.asciz 	"\n*** Leitura e Escrita de Registros ***\n"
	txtContinuar: 	.asciz 	"\nDeseja continuar: <1> - Sim  <2>- Nao\n"

	txtPedeNome:	.asciz	"\nDigite o nome: " #64Bytes
	txtPedeGenero:	 .asciz	"\nDigite o genero <M> ou <F>: " #4bytes
	txtPedeCPF:	.asciz	"\nDigite o CPF: " #16 bytes
	txtPedeRG:	.asciz	"\nDigite o RG: " #16bytes
	txtPedeTelefone:	.asciz	"\nDigite o Telefone: " #16bytes
	txtPedeDDD:	.asciz	"\nDigite o DDD: " #8bytes

	txtPedeDN:	.asciz	"\nDigite a data de nascimento\n" #12bytes
	txtPedeDia:	.asciz	"Dia: "
	txtPedeMes:	.asciz	"Mes: "
	txtPedeAno:	.asciz	"Ano: "
	txtPedeIdade:	.asciz	"\nDigite a idade: " #4bytes + #4bytes do ponteiro

	txtMostraReg:	.asciz	"\nRegistro Lido"
	txtMostraNome:	.asciz	"\nNome: %s"
	txtMostraGenero: .asciz	"Genero: %c"
	txtMostraRG:	.asciz	"\nRG: %s"
	txtMostraCPF:	.asciz	"\nCPF: %s"
	txtMostraDN:	.asciz	"\nData de Nascimento: %d/%d/%d"
	txtMostraIdade:	.asciz	"\nIdade: %d\n"
	txtMostraTelefone:	.asciz	"\nTelefone: (%s) %s\n"


	tipoNum: 	.asciz 	"%d"
	imprimeTipoNum: 	.asciz 	"%d\n"
	tipoChar:	.asciz	"%c"
	tipoStr:	.asciz	"%s"
	pulaLinha: 	.asciz 	"\n"

    
	opcao:		.int	0

	tamReg:  	.int 	144
	tamList:	.int 	0
	RG:			.int 	0

	listaReg:	.space  4
	reg:		.space	4
	teste:		.space 4

	NULL:		.int 0
	posicaoAtual: .int 0
	
.section .text
.globl _start
_start:

	pushl	$txtAbertura
	call	printf
	addl	$4, %esp

	call	leReg
	call	mostraReg

fim:
	pushl $0
	call exit

leReg:

	pushl	tamReg
	call	malloc
	movl	%eax, reg
	movl	reg, %edi

	_initLoop:

	pushl	$txtPedeNome
	call	printf
	addl	$8, %esp

	pushl	stdin
	pushl	$64
	pushl	%edi
	call	fgets

	popl	%edi
	addl	$8, %esp

	addl	$64, %edi
	pushl	%edi

	pushl	$txtPedeGenero
	call	printf
	addl	$4, %esp

	pushl	$tipoChar
	call	scanf		
	addl	$4, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$txtPedeRG
	call	printf
	addl	$4, %esp

	pushl	$tipoStr
	call	scanf

	addl	$4, %esp
	popl	%edi
	addl	$16, %edi
	pushl	%edi

	pushl	$txtPedeCPF
	call	printf
	addl	$4, %esp

	pushl	$tipoStr
	call	scanf

	addl	$4, %esp
	popl	%edi
	addl	$16, %edi
	pushl	%edi

	pushl	$txtPedeDN
	call	printf

	pushl	$txtPedeDia
	call	printf
	addl	$8, %esp

	pushl	$tipoNum
	call	scanf
	addl	$4, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$txtPedeMes
	call	printf
	addl	$4, %esp

	pushl	$tipoNum
	call	scanf
	addl	$4, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$txtPedeAno
	call	printf
	addl	$4, %esp

	pushl	$tipoNum
	call	scanf
	addl	$4, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi
	
	pushl	$txtPedeIdade
	call	printf
	addl	$4, %esp

	pushl	$tipoNum
	call	scanf
	addl	$4, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$txtPedeDDD
	call	printf
	addl	$4, %esp

	pushl	$tipoStr
	call	scanf
	addl	$4, %esp

	popl	%edi
	addl	$8, %edi
	pushl	%edi

	pushl	$txtPedeTelefone
	call	printf
	addl	$4, %esp

	pushl	$tipoStr
	call	scanf
	addl	$4, %esp

	popl %edi
	addl $16, %edi
	
	pushl 	$txtContinuar
	call 	printf

	pushl	$opcao
	pushl  $tipoNum
	call 	scanf
	addl	$12, %esp
	movl 	opcao,%eax
	
	cmpl  	$1,%eax
	je		_volta
	RET
	_volta:
		movl    tamList, %eax
		addl    $1, %eax
		movl    %eax, tamList
		pushl	tamReg
		call	malloc
		movl	%eax, (%edi)
		movl  	%eax, %edi
		
		pushl	$opcao
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp
		jmp _initLoop




mostraReg:


	movl	reg, %edi


	_loopDeLeitura:

	pushl	$txtMostraReg
	call	printf
	addl	$4, %esp

	pushl	%edi
	pushl	$txtMostraNome
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$64, %edi
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$txtMostraGenero
	call	printf
	addl	$8, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$txtMostraRG
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$16, %edi
	pushl	%edi

	pushl	$txtMostraCPF
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$16, %edi

	movl	(%edi), %eax
	addl	$4, %edi
	movl	(%edi), %ebx
	addl	$4, %edi
	movl	(%edi), %ecx

	pushl	%edi
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	pushl	$txtMostraDN
	call	printf
	addl	$16, %esp

	popl	%edi
	addl	$4, %edi
	movl	(%edi), %eax

	pushl   %edi
	pushl	%eax
	pushl	$txtMostraIdade
	call	printf
	addl	$8, %esp


	popl    %edi
	addl    $4,%edi

	movl	%edi,%eax
	addl    $8,%edi
	movl	%edi,%ecx

	pushl 	%ecx
	pushl 	%eax
	pushl 	$txtMostraTelefone
	call 	printf
	addl	$12, %esp
	addl 	$16, %edi
	movl 	posicaoAtual,%ebx
	cmpl 	%ebx, tamList
	je		_fimLoop

	addl	$8, %esp
	movl	(%edi),%esi
	movl  	%esi,%edi
	addl 	$1, %ebx
	movl	%ebx, posicaoAtual
	jmp 	_loopDeLeitura
	_fimLoop:
		RET

/*
DESAFIO: Modifique o codigo fazendo o seguinte:

1) Acrescente os seguintes campos, tanto na leitura quanto na mostragem:

- RG antes do CPF: 1 inteiro
- Contato telefonico, com DDD separado, depois da idade: 2+9 caracteres
- acrescente um campo de ponteiro, apos todos os campos: 4 bytes (space), mas não precisa fazer a leitura dele. Esse campo serah usado como "campo de proximo".

2) Mude o nome "reg" para "listaReg". Aloque n registros em loop. Leia n antes. Faça listaReg apontar para o primeiro registro lido, o primeiro deve apontar para o segundo, o segundo deve apontar para o terceiro, o terceiro para o quarto e assim sucessivamente. O decimo registro deve apontar para o endereco da variavel/rotulo NULL. Depois, imprima o n registros partindo do endereco inicial do primeiro, usando %edi para avançar de registro em registro.

Obs: Cada registro deverá ser alocado antes de sua leitura. Para um registro apontar para o proximo registro, o seu campo de proximo devera conter o endereco inicial do proximo registro. Cuidado para não sobreescrever um registro sobre o outro.

*/
