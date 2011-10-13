;=================================================================================================================================================================================================
;
;	set.single.attribute
;
;	This function sends a vt100 escape sequence to the remote terminal which changes a single attribute about the
;	printed text. Attributes can be found in the file "attribute.control.dat".
;
;	Assumptions:	eax = Pointer to attribute to insert.
;			esi = Pointer to descriptor associated with target connection.
;
;	Returns:	None.
;

set.single.attribute:	mov	esi, set.att.mod.1					; esi = Pointer to first portion of the set attribute escape sequence.
			mov	edi, buffer.1						; edi = Pointer to data buffer.
			mov	ecx, 002h						; ecx = Size of first portion of the set attribute escape sequence.

			repnz	movsb							; Copy the first portion of the set attribute escape sequence to the data buffer.

			mov	esi, eax						; esi = Pointer to attribute to be set.

			movsb								; Copy the attribute to be set to the data buffer.

			mov	esi, set.att.mod.3					; esi = Pointer to the last portion of the set attribute escape sequence.

			movsb								; Copy the last portion of the set attribute escape sequence to the data buffer.

			mov	eax, dword [esi]					; eax = Descriptor associated with target connected socket.
			mov	dword [socket.data.send.socket.descriptor], eax		; Point socket.send to the correct socket.
			mov	dword [socket.data.send.buffer.pointer], buffer.1	; Point socket.send to the data buffer.
			mov	dword [socket.data.send.buffer.l], 004h			; Provide the length of the buffer.
			call	socket.send						; Send the string to the socket and change the attribute remotely.

			ret								; Return to caller.
