;=================================================================================================================================================================================================
;
;	clear.screen
;
;	This function remotely clears the screen and places the cursor in the upper left hand corner.
;
;	Assumptions:	None.
;
;	Returns:	None.
;

clear.screen:	mov	ebx, external.data.cursor.home					; ebx - Pointer to filename for cursor.home external data.
		call	get.external.data						; Grab the cursor.home escape sequence.

		mov	dword [socket.data.send.buffer.pointer], external.data.buffer	; Point socket.send to the future location of the cursor.home escape sequence.
		mov	dword [socket.data.send.buffer.l], edx				; Provide the length of the sequence.
		call	socket.send							; Send the string to the connected socket, modifying the cursor position remotely.

		mov	ebx, external.data.clear.screen					; ebx - Pointer to filename for clear.screen external data.
		call	get.external.data						; Grab the clear.screen escape sequence.

		mov	dword [socket.data.send.buffer.pointer], external.data.buffer	; Point socket.send to the clr.scr escape sequence definition.
		mov	dword [socket.data.send.buffer.l], edx				; Provide the length of the string.
		call	socket.send							; Send the string to the connected socket, clearing the screen remotely.

		ret									; Return to caller.
