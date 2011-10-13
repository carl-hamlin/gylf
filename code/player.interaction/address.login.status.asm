;================================================================================================================================================================================================
;
;	address.login.status
;
;	This code performs handling for data submitted by a socket with 'login' status. Essentially, it determines whether or not the connection belongs to a new player or an old one, creates
;	player credentials in the case of a new player, and sets the connection status to 'passphrase'.
;
;	Assumptions:	esi = Pointer to descriptor associated with target socket
;
;	Returns:	None.
;

address.login.status:	call	recv.from.socket							; Get the data from the socket.

			mov	ebx, buffer.1								; ebx = Pointer to received data.
			call	buffer.strip								; Strip extra characters from the received data.

			call	check.login								; Make sure this character isn't already logged in.
			jnc	not.logged.in								; If the character isn't already logged in, proceed to the login code.

			mov	ebx, dword [esi+connection.descriptor.index]				; ebx - Descriptor associated with connected socket.

			mov	dword [socket.data.send.socket.descriptor], ebx				; Store socket descriptor for send function. 
			mov	dword [socket.data.send.buffer.pointer], socket.data.second.login.error	; Point send function to message indicating that the login was bad.
			mov	dword [socket.data.send.buffer.l], socket.data.second.login.error.l	; Store length of message for send function.
			call	socket.send								; Tell the petitioner that they're trying to log in a second time.
			
			call	clean.socket								; Clean up the socket data and get it ready for a new connection.
			
			mov	ecx, local.data.second.login.error					; ecx - Pointer to error message indicating a connection failed on credentials.
			mov	edx, local.data.second.login.error.l					; edx - Length of message.
			call	write.descriptor							; Tell the admin that somebody bounced.
			
			ret										; Return to caller.

not.logged.in:		mov	edi, esi								; edi = Pointer to connection table.
			add	edi, connection.filename.index						; edi = Pointer to empty socket filename entry.

			push	esi									; Preserve index to connection table.

			mov	ecx, eax								; ecx = Number of bytes received from socket.
			mov	esi, buffer.1								; esi = Pointer to received data.
			mov	ebx, edi								; ebx = Pointer to socket filename entry for later use with the open.descriptor function.

			repnz	movsb									; Store the filename.

			pop	esi									; Restore index to connection table.

			mov	ebp, eax								; ebp - Size of received data.
			call	open.descriptor								; See if there's already a user credentials file named after the data received. If so,
													; associate a descriptor with it.

			or	eax, eax								; If such a file exists, then we'll have succeeded in associating a descriptor with it,
			js	bad.login								; and the descriptor will be in eax. If not, then eax will be negative, and contain a
													; sign. We can use the sign to determine which. If eax is signed, we'll treat this like a
													; bad login. If it isn't, then we'll treat it as an good one.

			call	create.lock.file							; Assume the character is about to be logged and create a lock file to prevent multiple
													; instances.

			mov	ebx, eax								; ebx - descriptor associated with character data.
			mov	ecx, new.char.sig.buffer						; ecx - Pointer to buffer into which to read data.
			mov	edx, new.char.sig.l							; edx - Size of data to be read.
			call	read.descriptor								; Read a dword from the file.
			
			cmp	word [new.char.sig.buffer], new.char.sig				; Did we read a new character signature?
			jz	new.login								; If the received data matches the new character data prototype, go populate the
													; character file.

			jmp	returning.login								; Otherwise, treat this like a returning login.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

bad.login:		mov	ebx, dword [esi+connection.descriptor.index]				; ebx - Descriptor associated with connected socket.

			mov	dword [socket.data.send.socket.descriptor], ebx				; Store socket descriptor for send function. 
			mov	dword [socket.data.send.buffer.pointer], socket.data.bad.login.error	; Point send function to message indicating that the login was bad.
			mov	dword [socket.data.send.buffer.l], socket.data.bad.login.error.l	; Store length of message for send function.
			call	socket.send								; Tell the petitioner that their credentials aren't good here.
			
			call	clean.socket								; Clean up the socket data and get it ready for a new connection.
			
			mov	ecx, local.data.bad.login.error						; ecx - Pointer to error message indicating a connection failed on credentials.
			mov	edx, local.data.bad.login.error.l					; edx - Length of message.
			call	write.descriptor							; Tell the admin that somebody bounced.
			
			ret										; Return to caller.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

new.login:		mov	ebx, eax								; ebx = Descriptor associated with user's credential file.
			call	close.descriptor							; Disassociate the descriptor.

			mov	eax, dword [esi+connection.descriptor.index]				; eax = Descriptor associated with target socket.

			mov	dword [socket.data.send.socket.descriptor], eax				; Store socket descriptor for send function.
			mov	dword [socket.data.send.buffer.pointer], socket.data.welcome.message	; Point send function to welcome message.
			mov	dword [socket.data.send.buffer.l], socket.data.welcome.message.l	; Store length of message for send function.
			call	socket.send								; Send the welcome message on the socket.

			mov	dword [esi+connection.status.index], set.passphrase.status		; Set status of target socket to 'setting passphrase'.

			ret										; Return to caller.
			
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

returning.login:	call	close.descriptor							; Disassociate the descriptor.

			mov	eax, dword [esi+connection.descriptor.index]				; eax = Descriptor associated with target socket.

			mov	dword [socket.data.send.socket.descriptor], eax				; Store socket descriptor for send function.
			mov	dword [socket.data.send.buffer.pointer], socket.data.passphrase.message	; Point send function to message indicating a request for a passphrase.
			mov	dword [socket.data.send.buffer.l], socket.data.passphrase.message.l	; Store length of message for send function.
			call	socket.send								; Send the passphrase request on the socket.

			mov	byte [esi+connection.status.index], passphrase.status			; Set status of target socket to 'passphrase'.

			ret										; Return to caller.
