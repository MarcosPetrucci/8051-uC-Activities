;***********************************************
;*	Marcos Vinícius Firmino Pietrucci      *
;*	10770072			       *
;***********************************************

; ****************** PROGRAMA ******************

; Para armazenar o valor dos displays, usarei os registradores
;	1000H - R0
;	2000H - R1
;	3000H - R2
;	4000H - R3

; R1 para os 2 mais significativos, R2 para os 2 leds menos significativos
; Buffer: XDATA
;	  8000   D7S-0
;	  8100   D7S-1
;	  8200   D7S-2
;	  8300   D7S-3
;	  8400   D7S-4
;	  8500   D7S-5
;	  8600   D7S-6
;	  8700   D7S-7

		ORG	0H
		SJMP	SETUP

SETUP:
		MOV	R0, #0H		; Limpa os registradores que conterão o valor Hex ldo
		MOV	R1, #0H
		MOV	R2, #0H
		MOV	R3, #0H

LOOP:		ACALL	LE_MEMORIA
		ACALL	CONV2BCD_R0
		ACALL	CONV2BCD_R1
		ACALL	CONV2BCD_R2
		ACALL	CONV2BCD_R3
		SJMP	LOOP

LE_MEMORIA:	MOV	DPTR, #1000H
		MOVX	A, @DPTR
		MOV	R0, A
		MOV	DPTR, #2000H
		MOVX	A, @DPTR
		MOV	R1, A
		MOV	DPTR, #3000H
		MOVX	A, @DPTR
		MOV	R2, A
		MOV	DPTR, #4000H
		MOVX	A, @DPTR
		MOV	R3, A
		RET
;**********************************
;Função que converte o número no registrador R0 em BCD
;Já aproveita e envia o valor para a memória externa
CONV2BCD_R0:	MOV	A, R0
		MOV	B, #0AH
		DIV	AB
		MOV	31H, A	; 31H = ISB1
		MOV	30H, B	; 30H = LSB

		;Converte o valor de BCD para D7S
		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR	;O valor D7S está carregado no acumulador

		;Move o valor correto para a posição de memoria respectiva
		MOV	DPTR, #8000H
		MOVX	@DPTR, A

		;Converte o valor de BCD para D7S
		MOV	A, B
		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR	;O valor D7S está carregado no acumulador

		;Move o valor correto para a posição de memoria respectiva
		MOV	DPTR, #8100H
		MOVX	@DPTR, A
		RET

;**********************************
;Função que converte o número no registrador R1 em BCD
;Já aproveita e envia o valor para a memória externa
CONV2BCD_R1:	MOV	A, R1
		MOV	B, #0AH
		DIV	AB
		MOV	33H, A	; 33H = MSB
		MOV	32H, B	; 32H = ISB2

		;Converte o valor de BCD para D7S
		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR	;O valor D7S está carregado no acumulador

		;Move o valor correto para a posição de memoria respectiva
		MOV	DPTR, #8200H
		MOVX	@DPTR, A

		;Converte o valor de BCD para D7S
		MOV	A, B
		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR	;O valor D7S está carregado no acumulador

		;Move o valor correto para a posição de memoria respectiva
		MOV	DPTR, #8300H
		MOVX	@DPTR, A
		RET
;**********************************
;Função que converte o número no registrador R2 em BCD
;Já aproveita e envia o valor para a memória externa
CONV2BCD_R2:	MOV	A, R2
		MOV	B, #0AH
		DIV	AB
		MOV	35H, A	; 33H = MSB
		MOV	34H, B	; 32H = ISB2

		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR
		MOV	DPTR, #8400H
		MOVX	@DPTR, A

		MOV	A, B
		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR
		MOV	DPTR, #8500H
		MOVX	@DPTR, A

		RET

;**********************************
;Função que converte o número no registrador R3 em BCD
;Já aproveita e envia o valor para a memória externa
CONV2BCD_R3:	MOV	A, R3
		MOV	B, #0AH
		DIV	AB
		MOV	37H, A	; 33H = MSB
		MOV	36H, B	; 32H = ISB2

		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR
		MOV	DPTR, #8600H
		MOVX	@DPTR, A

		MOV	A, B
		MOV	DPTR, #D7SVALORES
		MOVC	A, @A+DPTR
		MOV	DPTR, #8700H
		MOVX	@DPTR, A
		RET

;**********************************
D7SVALORES:	DB	3FH, 06H, 05BH, 4FH, 66H, 6DH, 7DH, 07H, 7FH, 6FH


		END
