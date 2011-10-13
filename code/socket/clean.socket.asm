;=================================================================================================================================================================================================
;
;	clean.socket
;
;	This code removes the data associated with an active socket from memory, smokes the lock file, and uses the close.descriptor function to close out the socket. This function does not
;	closeout other files associated with the socket - that responsibility is left to the caller.
;
;	Assumptions:	esi = Index to connection tables.
;
;	Returns:	None.
;

clean.socket:	push	ecx						; Preserve caller's ecx register.
		mov	ebx, dword [esi+connection.descriptor.index]	; ebx = Descriptor associated with target socket.
		call	close.descriptor				; Disassociate the descriptor and shut down the socket.
		
		push	esi						; Preserve index to socket table.
		mov	edi, esi					; edi - Index to socket table.
		add	edi, connection.filename.index			; edi - Pointer to character data file name.
		mov	ebx, edi					; ebx - Pointer to character data file name.
		mov	ecx, lock.extension.l				; ecx - Length of lock extension.

ul.loop:	cmp	byte [edi], 00h					; Have we struck a zero?
		jz	ul.smoke					; Yes. Go tack on the lock extension.

		inc	edi						; edi - Pointer to next byte of character data file name.
		jmp	ul.loop						; Go check the next byte.

ul.smoke:	mov	esi, lock.extension				; esi - Pointer to lock extension.
		repnz	movsb						; Tack on the lock extension.

		pop	esi						; Restore index to connection table.

		mov	eax, sys.unlink					; eax - Smoke a file.
		int	sys.system.call					; Smoke the lock file.

		mov	dword [esi+connection.descriptor.index], 0000h	; Smoke the stored descriptor for the defunct socket.
		mov	byte [esi+connection.status.index], 00h		; Smoke the stored status for the defunct socket.
		sub	eax, eax					; eax = Zeroes for smoking the stored filename for the defunct socket's user credentials.
		mov	ecx, socket.filename.entry.l			; ecx = Number of times to write the zeroes to fill the entire filename entry.

		mov	edi, esi					; edi - Index to socket entry.
		add	edi, connection.filename.index			; edi - Pointer to socket filename entry.
		repnz	stosb						; Smoke the stored filename for the defunct socket.
		pop	ecx						; Restore caller's ecx register.

		ret							; Return to caller.
