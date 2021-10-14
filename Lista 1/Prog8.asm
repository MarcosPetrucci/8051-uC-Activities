		ORG 	0000H
		SJMP 	SETUP


SETUP:		MOV 	R0, #0H			;Quantidade de nros lidos
		MOV	R2, #0H			;Quantidade de nros pares
		MOV	R3, #0H			;Quantidade de nros impares
		MOV 	DPTR, #Valor
		MOV	B, #2H			;Divisor
LOOP:		MOV	A, R0
		INC	R0
		CJNE	R0, #11H, continua
		SJMP 	FINALIZA

continua:	MOVC	A, @A+DPTR		;Comando para mover valor
		MOV	R1, A			;Armazena o valor lido
		DIV	AB			;Resto vai para o registrador B
		MOV	A, B
		CJNE	A, #1H, Nro_Par
		SJMP	Nro_impar


Nro_Par:	MOV 	P1, R1

		;Enviar serial com 9600,N,8,1.

		INC	R2	;Armazena quantidade de pares

Nro_impar:	MOV	P2, R1

		;Enviar serial com 4800,N,8,1

		INC	R3	;Armazena quantidade de impares

finaliza:	;Mover para a RAM externa
		MOV	DPTR, #2030H
		MOV	A, R2
		MOVX	@DPTR, A

		MOV	DPTR, #2031H
		MOV	A,R3
		MOVX	@DPTR, A

Valor: DB 54, 23, 88, 215, 189, 98, 8, 11, 28, 100

END

