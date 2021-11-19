;Acender o número 0
;MOV A,#3Fh
;MOV DPTR,#8000H
;MOVX   @DPTR,A

;Ler os valores de 1000, 2000, 3000 e 4000
;Converter para BCD
;Enviar para as posições  a partir de 8000


ORG 0
SJMP	PROG

PROG:		

DMUX:		MOV	DPTR, #1000h
		MOVX	A, @DPTR

		;Acumulador recebe valor em hexadecimal
		

		MOV	A, #01
CONT:		ACALL 	APAGA_LEDS
		MOV 	P1, @R0
		MOV	P2, A
		RL	A		; 1, 10, 100, 1000....
		INC	R0
		CJNE	R0, #38H, DIGIT
DIGIT:		JC	CONT
		ACALL	APAGA
		RET

APAGA_LEDS:	MOV	P1,#00H ;Limpa os displays de 7 segmentos
		MOV	P2,#00H ;Desativa todos os displays
		RET

