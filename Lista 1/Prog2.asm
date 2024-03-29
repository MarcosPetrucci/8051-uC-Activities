		ORG 0000H
		SJMP SETUP

		ORG 0003H
		SJMP EXT_0

		ORG 000BH 
		SJMP TC0

		ORG 0013H
		SJMP EXT_1

SETUP:		SETB 	EA		;Habilitar as interrupcoes
		SETB	ET0
		SETB	EX0
		SETB	EX1
		MOV  	TMOD, #1H 	; Software, temporizador modo 1
		SETB	IT0
		SETB	IT1
		SETB	PX0		; IExt 0 e 1 de alta prioridade
		SETB	PX1
		CLR	PT0		; Interrupcao do temporizador de baixa prioridade
		MOV  	TH0, #0FFH 	; TC0 = 0.05s
		MOV  	TL0, #006H

		SETB 	TR0

		SJMP	$

;*********************************************************
EXT_0:		CLR 	EA		; Previne que seja interrompida
		MOV	DPTR, #4000H
		MOVX	A,@DPTR
		MOV	DPTR, #4200H
		MOVX	@DPTR,A
		SETB	EA
		RETI

;*********************************************************
EXT_1:
		MOV	DPTR, #4200H
		MOVX	A,@DPTR
		MOV	P1, A
		RETI

;*********************************************************
TC0:
		MOV	A, P2
		MOV	DPTR, #4000H
		MOVX	@DPTR, A
		RETI

END