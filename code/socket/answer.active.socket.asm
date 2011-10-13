;=================================================================================================================================================================================================
;
;	answer.active.socket
;
;	This code determines the status of an active socket and routes the data to the appropriate handler.
;
;	Assumptions:	esi = Index to connection tables.
;
;	Returns:	None.
;

answer.active.socket:	mov	ecx, local.data.active.socket.message				; ecx - Pointer to socket activity notifier.
			mov	edx, local.data.active.socket.message.l				; edx - Length of socket activity notifier.
			call	write.descriptor						; Let the admin know we're working with an active socket.

			call	print.socket.number						; Let the admin know what socket is active.

			mov	ecx, local.data.carriage.return					; ecx - Pointer to carriage return.
			mov	edx, local.data.carriage.return.l				; edx - Length of carriage return.
			call	write.descriptor						; Print the carriage return.

			cmp	byte [esi+connection.status.index], login.status		; Is the connection in 'login' status?
			jnz	not.login.status						; No. Go check for 'passphrase' status.

			jmp	address.login.status						; Yes. Pass control to address.login.status.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

not.login.status:	cmp	byte [esi+connection.status.index], passphrase.status		; Is the connection in 'passphrase' status?

			jnz	not.passphrase.status						; No. Go check for 'setting passphrase' status.

			jmp	address.passphrase.status					; Yes. Pass control to address.passphrase.status.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

not.passphrase.status:	cmp	byte [esi+connection.status.index], set.passphrase.status	; Is the connection in 'setting passphrase' status?

			jnz	address.active.status						; No. Pass control to address.active.status.

			jmp	address.set.passphrase.status					; Yes. Pass control to address.set.passphrase.status.
