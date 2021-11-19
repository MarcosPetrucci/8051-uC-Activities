;Para o contador, usarei dois registradores 8 bits R0 e R1
;R1 para os 2 mais significativos, R2
		ORG	0H
		SJMP	SETUP

		ORG	00BH
		SJMP	TC0

		ORG	013H
		ACALL	EXT_1
		RETI

SETUP:		SETB	EA
		SETB	EX1
		SETB	IT1
		MOV	R0, #0H		;Limpa os contadores
		MOV	R1, #0H
		MOV	R2, #0H		;Armazena qual o bit ativo
		MOV	30H, #0H	;Limpa o buffer
		MOV	31H, #0H
		MOV	32H, #0H
		MOV	33H, #0H
		MOV	P2, #00H	;Limpa os ativadores

LOOP:		MOV	P2, #00H
		ACALL	D7S



;**********************************
;Função envia ao D7S os valores armazenados no buffer
D7S:		MOV	DPTR,#TABELA
		CJNE	R2, #3H, TESTA_2
		MOV	A, 33H
		SJMP	MOSTRA

TESTA_2:	CJNE	R2, #2H, TESTA_1
		MOV	A, 32H
		SJMP	MOSTRA

TESTA_1:	CJNE	R2, #1H, TESTA_0
		MOV	A, 31H
		SJMP	MOSTRA

TESTA_0:	MOV	A, 30H
		SJMP	MOSTRA

MOSTRA:		MOVC	A, @A+DPTR
		MOV	P1, A

		ACALL	ATIVA_D7S
		RET
TABELA:		DB	3FH, 06H, 05BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH

;************************************
ATIVA_D7S:	CJNE	R2, #3H, ATIVA_2
		SETB	P2.3
		RET

ATIVA_2:	CJNE	R2, #2H, ATIVA_1
		SETB	P2.2
		RET

ATIVA_1:	CJNE	R2, #1H, ATIVA_0
		SETB	P2.1
		RET

ATIVA_0:	CJNE	R2, #0H, TESTA_2
		SETB	P2.0
		RET
;**********************************
TC0:		CLR	EA
		MOV	R0, #31H
		;ACALL	DISPLAY_MUX
		MOV	TH0, #0FFH
		MOV	TL0, #0FFH
		SETB	EA
		RETI

;**********************************
EXT_1:		JNB	20H.0, ATIVA_BIT
		CLR	20H.0		;O bit estava ativado. Reativar a contagem
		MOV	A, #0C8H	;Faz a contagem recomeçar do zero
		RET
ATIVA_BIT:	SETB 	20H.0		;Seta a flag de parada do programa
		RET

		END
