INCLUDE Irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
	L DWORD ?
	cprompt BYTE "Press any key to end...", 0
	array BYTE "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
.code
main proc
	call Randomize					;initialize RandomRange to a random value
	mov eax, 21						;random value between 0 and 19
	inc eax							;up random value to between 1 and 20
	call RandomRange				;returns random value into eax
	mov L, eax						;copy random value into L
	string BYTE L DUP('#')			;create string with L amount of placeholder #
	mov ecx, 20						;loop calling RandString 20 times
	L1:
		mov eax, L					;pass the value of L in EAX
		mov esi, OFFSET string		;pass a pointer to array of byte (string)
		call RandString				
		loop L1
	mov edx, OFFSET cprompt			;point edx to cprompt start
	call WriteString				;writes cprompt to console
	call ReadChar					;waits to read input from keyboard
	invoke ExitProcess, 0
main endp
end main

RandString proc
	mov ecx, SIZEOF esi				;move size of string to ecx to loop that amount of times
	L2:
		mov eax, 26					;generate random int between 0 and 25 (26 letters in alphabet)
		call RandomRange			;returns random value into eax
		mov [esi], array[eax]		;copy character at array index eax to pointer esi
		inc esi						;increment esi to point to next index in string
		loop L2
	mov edx, OFFSET string			;point edx to string start
	call WriteString				;writes string to console
	ret
RandString endp
