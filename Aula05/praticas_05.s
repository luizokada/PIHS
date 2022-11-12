.section .data
    saida: .asciz "Teste %d: Resultado = Hex: %X Dec: %d\n\n"
    saida2: .asciz "Teste %d: Quoc > Hex: %X Dec: %d e Resto > Hex: %X Dec: %d\n\n"
    saida3: .asciz "Teste %d: Resultado = Hex: %X:%X\n\n"
.section .text
.globl _start
_start:
    # Soma de registradores de 32 bits com dados naturais
    movl $0x12340000, %eax  # 305.397.760 em decimal
    movl $0x00005678, %ebx  #      22.136 em decimal
    addl %ebx, %eax         # %eax ← %eax + %ebx
    pushl %eax
    pushl %eax
    pushl $1
    pushl $saida
    call printf

    # Soma de registradores de 32 bits com dados negativos
    movl $0xCFFF1234, %eax  # -805.367.244 em decimal
    movl $0xDFFF5678, %ebx  # -536.914.312 em decimal
    addl %ebx, %eax         # %eax ← %eax + %ebx
    pushl %eax
    pushl %eax
    pushl $2
    pushl $saida
    call printf

    # somando registradores de 16 bits, com dados naturais.
    movl $0x11001234, %eax  # 285.217.332 em decimal
    movl $0x00114321, %ebx  #   1.131.297 em decimal
    addw %bx, %ax           # %ax <- %ax + %bx
    pushl %eax
    pushl %eax
    pushl $3
    pushl $saida
    call printf

    # 5) somando registradores de 16 bits, com dados negativos.
    movl $0xFFFFF456, %eax  # -2986 em decimal
    movl $0xFFFFFCBB, %ebx  #  -837 em decimal
    addw %bx, %ax           # %ax <- %ax + %bx : -3.823
    pushl %eax
    pushl %eax
    pushl $4
    pushl $saida
    call printf

    # 6) somando registradores de 8 bits no al, com dados naturais.
    movl $0x11005534, %eax  # 285.234.484 em decimal
    movl $0x0011AA21, %ebx  #   1.157.665 em decimal
    addb %bl, %al           # %al <- %al + %bl
    pushl %eax
    pushl %eax
    pushl $5
    pushl $saida
    call printf

    # 7) somando registradores de 8 bits no al, com dados negativos.
    movl $0xFFFFFF56, %eax  # -170 em decimal
    movl $0xFFFFFFBB, %ebx  #  -69 em decimal
    addb %bl, %al           # %al <- %al + %bl
    pushl %eax
    pushl %eax
    pushl $6
    pushl $saida
    call printf

    _break1:
    
    # 8) somando registradores de 8 bits no ah, com dados naturais.
    movl $0x11005534, %eax  # 285.234.484 em decimal
    movl $0x0011AA21, %ebx  #   1.157.665 em decimal
    addb %bh, %ah           # %ah <- %ah + %bh
    pushl %eax
    pushl %eax
    pushl $7
    pushl $saida
    call printf

    # 9) somando registradores de 8 bits no al, com dados negativos.
    movl $0xFFFFFF56, %eax  # -170 em decimal
    movl $0xFFFFFFBB, %ebx  #  -69 em decimal
    addb %bh, %ah           # %ah <- %ah + %bh
    pushl %eax
    pushl %eax
    pushl $8
    pushl $saida
    call printf

    # 10) subtraindo registradores de 32 bits, com dados naturais.
    movl $0x12345678, %eax  # 305.419.896
    movl $0x02040608, %ebx  # 33.818.120
    subl %ebx, %eax         # %eax ← %eax - %ebx
    pushl %eax
    pushl %eax
    pushl $9
    pushl $saida
    call printf

    # 11) subtraindo registradores de 32 bits, com dados negativos.
    movl $-1412627919, %eax
    movl $-2627000, %ebx
    subl %ebx, %eax         # %eax <- %eax - %ebx
    pushl %eax
    pushl %eax
    pushl $10
    pushl $saida
    call printf

    # 12) subtraindo registradores de 16 bits, com dados naturais.
    movl $0x12345678, %eax  # 305.419.896
    movl $0x02040608, %ebx  # 33.818.120
    subw %bx, %ax           # %ax ← %ax - %bx
    pushl %eax
    pushl $11
    pushl $saida
    call printf

    # 13) subtraindo registradores de 16 bits, com dados negativos.
    movl $-0x1234ABFF, %eax # -305.441.791 (dec) ou EDCB5401 (cp2)
    movl $-0xABFF, %ebx     # -44.031 (dec) ou FFFF5401 (cp2)
    subw %bx, %ax           # %ax <- %ax - %bx
    pushl %eax
    pushl %eax
    pushl $12
    pushl $saida
    call printf

    # 14) subtraindo registradores de 8 bits no al, com dados naturais.
    movl $0x12345678, %eax  # 305.419.896
    movl $0x02040608, %ebx  # 33.818.120
    subb %bl, %al           # %al ← %al - %bl
    pushl %eax
    pushl %eax
    pushl $13
    pushl $saida
    call printf

    # 15) subtraindo registradores de 8 bits no al, com dados negativos.
    movl $-0x1234ABFF, %eax # -305.441.791 (dec) ou EDCB5401 (cp2)
    movl $-0xABFF, %ebx     # -44.031 (dec) ou FFFF5401 (cp2)
    subb %bl, %al           # %al ← %al - %bl
    pushl %eax
    pushl %eax
    pushl $14
    pushl $saida
    call printf

    # 16) subtraindo registradores de 8 bits no ah, com dados naturais.
    movl $0x12345678, %eax  # 305.419.896
    movl $0x02040608, %ebx  # 33.818.120
    subb %bh, %ah           # %ah ← %ah - %bh
    pushl %eax
    pushl %eax
    pushl $15
    pushl $saida
    call printf

    # 17) subtraindo registradores de 8 bits no ah, com dados negativos.
    movl $-0x1234ABFF, %eax # -305.441.791 (dec) ou EDCB5401 (cp2)
    movl $-0xABFF, %ebx     # -44.031 (dec) ou FFFF5401 (cp2)
    subb %bh, %ah           # %ah ← %ah - %bh
    pushl %eax
    pushl %eax
    pushl $16
    pushl $saida
    call printf

    # 18) incrementando registradores de 32, 16 e 8 bits
    movl $0xA4, %eax
    incl %eax   # %eax ← %eax + 1
    incw %ax    # %ax ← %ax + 1
    incb %al    # %al ← %al + 1
    pushl %eax
    pushl %eax
    pushl $17
    pushl $saida
    call printf

    # 19) decrementando registradores de 32, 16 e 8 bits
    movl $0xA4, %eax
    decl %eax   # %eax ← %eax - 1
    decw %ax    # %ax ← %ax - 1
    decb %al    # %al ← %al - 1
    pushl %eax
    pushl %eax
    pushl $18
    pushl $saida
    call printf

    _break2:

    # 20) dividindo dado de 64 bits por dado de 32 bits, com inteiros sem sinal, gerando um dado de 32 bits.
    movl $0x0000A4C8, %edx
    movl $0x00001234, %eax
    movl $0xA4C80, %ebx
    divl %ebx               # %eax ← %edx:%eax / %ebx
    pushl %edx
    pushl %edx
    pushl %eax
    pushl %eax
    pushl $19
    pushl $saida2
    call printf

    # 21) dividindo dado de 64 bits por dado de 32 bits, sendo o dividendo natural e o divisor negativo, gerando um dado de 32 bits.
    movl $0x0000A4C8, %edx
    movl $0x00001234, %eax
    movl $-0xA4C80, %ebx
    idivl %ebx              # %eax ← %edx:%eax / %ebx
    pushl %edx
    pushl %edx
    pushl %eax
    pushl %eax
    pushl $20
    pushl $saida2
    call printf

    # 22) dividindo dado de 64 bits por dado de 32 bits, sendo o dividendo negativo e o divisor natural, gerando um dado de 32 bits.
    # Como representar um número negativo que precisa estar contido em um par de registrador (%edx:%eax)?
    # Após mover os números no formato negativo, devemos subtrair 1 do %edx, para cancelar o +1 realizado pelo complemento de 2
    movl $-0x0000A4C8, %edx
    subl $1, %edx           # anulamos o cp2 e apenas mantemos o cp1
    movl $-0x00001234, %eax
    movl $0xA4C80, %ebx
    idivl %ebx              # %eax ← %edx:%eax / %ebx
    pushl %edx
    pushl %edx
    pushl %eax
    pushl %eax
    pushl $21
    pushl $saida2
    call printf

    # 23) dividindo dado de 32 bits por dado de 32 bits, ambos naturais, gerando um dado de 32 bits.
    movl $0, %edx
    movl $0x24682467, %eax
    movl $2, %ebx
    divl %ebx               # %eax ← %edx:%eax / %ebx
    pushl %edx
    pushl %edx
    pushl %eax
    pushl %eax
    pushl $22
    pushl $saida2
    call printf

    # 24) dividindo dado de 32 bits por dado de 32 bits, sendo o dividendo natural e o divisor negativo, gerando um dado de 32 bits
    movl $0, %edx
    movl $0x24682467, %eax
    movl $-2, %ebx
    idivl %ebx              # %eax ← %edx:%eax / %ebx
    pushl %edx
    pushl %edx
    pushl %eax
    pushl %eax
    pushl $23
    pushl $saida2
    call printf

    # 25) dividindo dado de 32 bits por dado de 32 bits, sendo o dividendo negativo e o divisor natural, gerando um dado de 32 bits
    movl $-0x24682467, %eax
    movl $2, %ebx
    cdq
    # A instrução cdq (Convert Doubleword to Quadword), ajusta o número negativo de 32 bits que esta em %eax 
    # para os 64 bits do par "%edx:%eax
    idivl %ebx              # %eax ← %edx:%eax / %ebx
    pushl %edx
    pushl %edx
    pushl %eax
    pushl %eax
    pushl $24
    pushl $saida2
    call printf

    # 26) dividindo dado de 32 bits por dado de 16 bits, com inteiros sem sinal, gerando um dado de 16 bits.
    movl $0, %eax
    movl $0x1, %edx
    movw $0x2F73, %ax
    movw $0x12F7, %bx
    divw %bx                # %ax ← %dx:%ax / %bx, o resto fica em %dx
    pushl %edx
    pushl %edx
    pushl %eax
    pushl %eax
    pushl $25
    pushl $saida2
    call printf

    # 27) dividindo dado 16 bits por dado de 8 bits, com inteiros sem sinal, gerando um dado de 8 bits.
    # OBS: %ah:%al = %ax
    movl $0, %eax
    movl $0, %edx
    movw $0x01F5, %ax
    movb $0x1F, %bl
    divb %bl                # %al ← %ax / %bl, o resto fica em %ah
    movl %eax, %edx
    sarw $8,%dx
    pushl %edx
    pushl %edx
    andw $0x00FF, %ax
    pushl %eax
    pushl %eax
    pushl $26
    pushl $saida2
    call printf

    _break3:
    
    # 28) multiplicando dado de 32 bits por dado de 32 bits, com inteiros sem sinal, gerando um dado de 64 bits
    movl $0xFFFFFFFF, %eax
    movl $0x2, %ebx
    mull %ebx               # %edx:%eax ← %eax * %ebx
    pushl %eax
    pushl %edx
    pushl $27
    pushl $saida3
    call printf

    # 29) multiplicando dado de 16 bits por dado de 16 bits, com inteiros sem sinal, gerando um dado de 32 bits
    movl $0, %edx           # apenas para limpar antes
    movl $0, %eax           # apenas para limpar antes
    movw $0xFFFF, %ax
    movw $0x2, %bx
    mulw %bx                # %dx:%ax ← %ax * %bx
    pushl %eax
    pushl %edx
    pushl $28
    pushl $saida3
    call printf

    # 30) multiplicando dado de 8 bits por dado de 8 bits, com inteiros sem sinal, gerando um dado de 16
    # bits. OBS: %ah:%al = %ax
    movl $0, %edx           # apenas para limpar antes
    movl $0, %eax           # apenas para limpar antes
    movb $0xFF, %al
    movb $0x2, %bl
    mulb %bl                # %ah:%al ← %al * %bl
    pushl %eax
    pushl %eax
    pushl $29
    pushl $saida
    call printf


    pushl $0
    call exit
