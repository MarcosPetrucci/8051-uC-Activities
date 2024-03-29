;***********************************************
;*	Marcos Vinícius Firmino Pietrucci      *
;*	10770072			       *
;***********************************************

; ********* PROGRAMA 2 ***************
ORG 0
		SJMP PROG

;************************************
ORG 0003H
		SJMP EXT_0

;*************************************
ORG 001BH 	; Local da interrupcao do TC 1!!
		SJMP TIMER_1
;*************************************

PROG:		SETB EA		;Habilita interrupcoes
		SETB ET1	;Habilita a interr. do timer 1
		SETB EX0	;Habilita a interr. externa 0
		SETB IT0	;Configura a ext0 como descida de borda
		MOV TMOD, #50h   ;#0101000b TC 1: Deixar disparo por software no modo de contador no modo 1
		SETB TR1	;Começa a largada do timer 1

		MOV 20H, #00H	;A posicao 20H armazenara a contagem
		MOV TH1, #0FFH
		MOV TL1, #0FBH	; 5 Pulsos para ligar o LED
		MOV P2,  #0FFH

		SJMP $

;***************** INTERRUPCAO TIMER 0 ********************
TIMER_1:	MOV A, 20H
		INC A

		CJNE A, #1H, opcao1
		CLR P2.0	;Liga o primeiro LED e coloca no TC1 o valor para contar até 10
		MOV TH1, #0FFH
		MOV TL1, #0F6H
		SJMP retorno

opcao1:		CJNE A, #2H, opcao3
		CLR P2.1
		MOV TH1, #0FFH ;Liga o segundo LED e coloca no TC1 o valor para contar até 20
		MOV TL1, #0ECH
		SJMP retorno

opcao3:		CJNE A, #3H, retorno
		CLR P2.2

retorno:	MOV 20H, A
		RETI

;**************** INTERRUPCAO EXTERNA 0 ********************
EXT_0:		MOV 20H, #00H
		MOV TH1, #0FFH
		MOV TL1, #0FBH	;Reinicia a contagem no TC1
		MOV P2,  #0FFH	;Limpa os LEDS
		RETI

END