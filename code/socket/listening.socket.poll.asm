;================================================================================================================================================================================================
;
;	listening.socket.poll
;
;	This function polls the listening socket for new connection attempts and sends the login message when it finds them.
;
;	Assumptions:	None.
;
;	Returns:	None.
;

listening.socket.poll:		mov	ebx, socket.data.event.socket.descriptor				; ebx = Pointer to descriptor associated with listening socket.
				mov	ecx, sys.poll.number.of.structures					; ecx = Number of sockets to poll.
				mov	edx, sys.poll.timeout							; edx = Number of milliseconds to wait on poll results before moving along.
				call	poll.descriptor								; Poll the socket.

				cmp	eax, sys.poll.in							; Is someone knocking?
				jnz	listening.socket.poll.done						; Nope. Go return to caller.

				call	accept.socket								; Yes. Let's let them in!

				or	eax, eax								; Did a descriptor successfully manage to become associated with the new socket?
				jns	greet									; Yes! Go tell the new guy it's time to log in!

				jmp	socket.accept.error							; Nope. Something is seriously wrong here. Go tell the admin we're screwed and
														; bail out.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

listening.socket.poll.done:	ret										; Return to caller.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

greet:				mov	esi, connection.table							; esi = Index to connection tables.
				mov	ecx, socket.number							; ecx = Number of entries.

greet.loop			cmp	dword [esi+connection.descriptor.index], dead.socket			; Is the current entry occupied?
				jz	greet.add.socket							; No! Let's occupy it!

				add	esi, connection.entry.size						; Yes. esi = pointer to the next entry.

				loop	greet.loop								; Go check the next entry.

				push	eax									; Preserve descriptor associated with new connection. If we're here, the table is
														; full up and there's no room for a new person. Bad news, bud.

				mov	dword [socket.data.send.socket.descriptor], eax				; Store socket descriptor for sending.	
				mov	dword [socket.data.send.buffer.pointer], no.connection.available	; Point send function to message indicating that no connection is available.
				mov	dword [socket.data.send.buffer.l], no.connection.available.l		; Store length of message for send function
				call	socket.send								; Tell the poor bastard we're all full up.

				pop	ebx									; ebx = descriptor associated with new connection.

				call	close.descriptor							; Drop the new connection.

				ret										; Return to caller.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

greet.add.socket:		mov	dword [esi+connection.descriptor.index], eax				; Store descriptor as a new entry.
				mov	byte [esi+connection.status.index], login.status			; Store status as a new entry.

				mov	dword [socket.data.send.socket.descriptor], eax				; Point socket.send at the new socket.
				call	clear.screen								; Clear that fellow's screen.

				mov	dword [socket.data.send.buffer.pointer], socket.data.login.message	; Point send function at message indicating a need for login credentials.
				mov	dword [socket.data.send.buffer.l], socket.data.login.message.l		; Store length of message for send function.
				call	socket.send								; Tell the new guy that we'll need some login credentials.

				mov	ecx, local.data.connection.notifier					; ecx = Pointer to connection notification message.
				mov	edx, local.data.connection.notifier.l					; edx = Length of message.
				call	write.descriptor							; Tell the admin there's a new connection.

				ret										; Return to caller.
