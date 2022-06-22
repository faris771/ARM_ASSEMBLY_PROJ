 AREA RESET, DATA, READONLY
	
	
    EXPORT __Vectors

__Vectors DCD 0x20001000

                DCD Reset_Handler

               ALIGN


ARRAY DCB 34, 56, 27, 156, 200, 68, 128,235, 17, 45



       AREA MYRAM, DATA, READWRITE

SUM  DCD 0
EVEN DCD 0 
	
LP2_ARRAY DCB 1,1,1,1,1,1,1,1,1,1 ; LARGEST POWER OF 2 INITIALLY ONE 

       AREA MYCODE, CODE, READONLY

        ENTRY

        EXPORT Reset_Handler

;IMPLEMENTING THE POW2 PROC



POW2 PROC

LOOP3
	TST R3, #1
	LSREQ R3, #1
	LSLEQ R4, #1
	BEQ LOOP3
	STRB R4, [R1]
	
	BX LR
	ENDP


Reset_Handler



;;;;;;;;your assembly code here 
	LDR R1, =ARRAY
	
	MOV R4, #10 ; 10 NUMBER OF ELEMENTS IN THE ARRAY  
	

LOOP

	LDRB R2, [R1]	;	 B: BYTE
	ADD R1, R1, #1 ; ITERATE 
	
	ADD R3, R3, R2 ; SUM 
	
	SUBS R4, R4 , #1 ;DECREMENT S FOR FLAG 
	
	
	BNE LOOP ; NOT EQUAL ZERO 
	
	LDR R5 , =SUM ; GETS THE ADDRESS OF SUM AND STORES IT IN R5
	
	STR R3, [R5] ; STORES LOCAL SUM (R3) INTO GLOBAL SUM WHICH ITS ADDRESS IN R5 

	; QUESTION C :: 


	LDR R1, =ARRAY
	MOV R4, #10
	LDR R6, =EVEN ; 
	
	
LOOP2

	LDRB R2, [R1]	;	 B: BYTE
	TST R2 , #1
	ADDEQ R7,R7,R2
	ADD R1, R1, #1 ; ITERATE 
	SUBS R4, R4 , #1 ;DECREMENT S FOR FLAG 	
	BNE LOOP2 ; NOT EQUAL ZERO 
	
	STR R7, [R6] ; STORES INTO MEMORY
	
	
	
	
; QUESTION  : D
	BIC R1, #0xFFFFFFFF
	BIC R2, #0xFFFFFFFF
	BIC R3, #0xFFFFFFFF
	BIC R4, #0xFFFFFFFF
	BIC R0, #0xFFFFFFFF
	BIC R5, #0xFFFFFFFF
	


	LDR R0, =ARRAY
	LDR R1, =LP2_ARRAY

	MOV R2, #10 ; SIZE OF ARRAY AND = NUMBER OF ITERATIONS

LOOP4
	LDRB R3, [R0]
	MOV R4 , #1
	BL POW2
	ADD R0,R0,#1
	ADD R1,R1,#1
	SUBS R2,R2,#1
	BNE LOOP4
	

 
Stop  B Stop

		end
