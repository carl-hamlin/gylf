;=================================================================================================================================================================================================
;
;   address.passphrase.status
;
;   This code performs detailed processing of data received from sockets with the 'passphrase' status. Essentially, it assumes the received data is intended to represent a passphrase, and
;   compares the data to the stored passphrase for the user. If they match, then the user's status is set to 'active' and control is passed back to the caller. If they do not match, then the
;   user is informed of the situation and disconnected.
;
;   Assumptions:    esi = Pointer to socket table.
;
;   Returns:        None.

	address.passphrase.status:	call	recv.from.socket								; Grab the data from the socket.

					mov	ebx, esi									; ebx = Pointer to connection tables.
					add	ebx, connection.filename.index							; ebx = Pointer to file path associated with user credentials.
					call	open.descriptor									; Associate a descriptor with the user's credential file.

					mov	ebx, eax									; ebx = Descriptor associated with user credential file.
					mov	ecx, buffer.2									; ecx = Pointer to buffer into which to read data from the user's credential file.
					mov	edx, byte.l									; edx = Number of bytes to read.
					call	read.descriptor									; Read the number of bytes to query.

					mov	ecx, buffer.2									; ecx = Pointer to read buffer.
					sub	edx, edx									; edx - Prepared for number of bytes to read.
					mov	dl, byte [buffer.2]								; edx = Number of bytes to read.
					call	read.descriptor									; Read the passphrase.

					push	eax										; Preserve number of bytes read.

					call	close.descriptor								; Disassociate the descriptor.

					pop	eax										; Restore number of bytes read.

					mov	ebx, buffer.2									; Pointer to read data.

					push	esi										; Preserve index to connection tables.

					mov	ecx, eax									; ecx = Number of bytes read.
					mov	esi, buffer.1									; esi = Pointer to data received from socket.
					mov	edi, buffer.2									; edi = Pointer to data read from file.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	passphrase.cmp.loop:		repz	cmpsb										; See if they match.
					jcxz	good.passphrase									; If ecx iz zero, we got all the way through. Go send a welcome.

					jmp	bad.passphrase									; Otherwise, go tell the user he's SOL and smoke his connection.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	good.passphrase:		pop	esi										; Restore index to connection tables.

					mov	byte [esi+connection.status.index], active.status				; Set connection status to 'active'.
					call	write.welcome									; Print the welcome screen.

					ret											; Return to caller.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	bad.passphrase:			pop	esi										; Restore index to connection tables.

					mov	eax, dword [esi+connection.descriptor.index]					; eax - descriptor associated with active connection.
					mov	dword [socket.data.send.socket.descriptor], eax					; Store descriptor associated with active connection.
					mov	dword [socket.data.send.buffer.pointer], socket.data.bad.passphrase.message	; Point send function to message indicating that the passphrase was bad.
					mov	dword [socket.data.send.buffer.l], socket.data.bad.passphrase.message.l		; Store length of message for send function.
					call	socket.send									; Tell the user that he's SOL.

					call	clean.socket									; Smoke that connection!

					ret											; Return to caller.
