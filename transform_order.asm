;Napisati asemblerski makro koji prima adresu niza karaktera u memoriji i njegovu duzinu, te preuredjuje niz tako da
;karakteri budu smjesteni obrnutim redolsijedom u odnosu na originalni. U okviru makroa nije dozvoljeno kreiranje novog niza.
;Stanje memorije i registara nakon zavrsetka rada makroa mora biti isto kao i prije pozivanja (ne racunajuci niz sa kojim makro
;radi). U glavnom programu testirati napisani makro.

SECTION	.data
array 	db	'abcdg'
array_lenght	equ $-array

SECTION	.text
global _start

%macro	 transform	2
MOV ESI,%1	;address of first element
MOV EDI,%1
ADD EDI,%2
DEC EDI		;address of last element

MOV ECX, %2
SHR ECX,1	;half of lenght

%%iterate:
      MOV AL,[ESI]	
      XCHG AL,[EDI]
      MOV [ESI],AL
      
      INC ESI
      DEC EDI
      LOOP %%iterate
%endmacro

_start:

PUSH ESI
PUSH EDI
PUSH ECX
PUSH EAX
   
transform array,array_lenght	;call macro function
    
POP EAX
POP ECX
POP EDI
POP ESI

MOV EAX,1
MOV EBX,0
INT 80h
  