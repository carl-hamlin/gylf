;=================================================================================================================================================================================================
;
;   get.character.data
;
;   This function populates the character data for the character controlled by the active socket.
;
;   Assumptions:    esi - Index to connection table.
;
;   Returns:        [character.data] - Data for the current character.
;

	get.character.data:	mov	ebx, esi			; Pointer to socket table.
				add	ebx, connection.filename.index	; Pointer to socket filename.
				call	open.descriptor			; Associate a descriptor with the filename.

				mov	ebx, eax			; ebx - Descriptor associated with character data.
				mov	ecx, buffer.2			; ecx - Pointer to buffer into which to read the length of the passphrase.
				mov	edx, byte.l			; edx - Size of data to be read.
				call	read.descriptor			; Read the length of the passphrase.

				mov	ecx, buffer.2			; ecx - Pointer to buffer into which to read the passphrase.
				sub	edx, edx			; edx - Prepared for length of passphrase.
				mov	dl, byte [buffer.2]		; edx - Length of passphrase.
				call	read.descriptor			; Read the passphrase.

				mov	ecx, character.data		; ecx - pointer to buffer into which to read the character data.
				mov	edx, character.data.l		; edx - Length of character data.
				call	read.descriptor			; Read the character data.

				call	close.descriptor		; Disassociate the descriptor.

				ret					; Return to caller.
