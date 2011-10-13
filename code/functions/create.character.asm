;====================================================================================================================================================================================================
;
;	create.character
;
;	This function builds out character data on the basis of the DNA sequences provided by the parents of the egg.
;
;	Assumptions:	eax - Descriptor associated with an egg file.
;			esi - Index to socket entry.
;
;	Returns:	None.
;

create.character:			push	eax										; Preserve descriptor associated with the egg file.

					mov	ebx, eax									; ebx - descriptor associated with the egg file.
					mov	ecx, egg.data									; ecx - pointer to buffer in which to store the egg data.
					mov	edx, egg.data.l									; edx - length of egg data.
					call	read.descriptor									; Read the egg data into the buffer.

					pop	ebx										; ebx - descriptor associated with the egg file.
			
					call	close.descriptor								; Close the egg file.

					push	esi										; Preserve index to socket entry.

					sub	ecx, ecx									; ecx - Prepared for loading.
					mov	cl, byte [egg.mother.l]								; ecx - length of mother's name.
					mov	esi, egg.mother									; esi - pointer to mother's name.
					mov	edi, character.mother								; edi - pointer to entry for mother's name on character template.

					mov	byte [character.mother.l], cl							; Store length of mother's name in character template.
					repnz	movsb										; Store mother's name in character template.
			
					sub	ecx, ecx									; ecx - Prepared for loading.
					mov	cl, byte [egg.father.l]								; ecx - length of father's name.
					mov	esi, egg.father									; esi - pointer to father's name.
					mov	edi, character.father								; edi - pointer to entry for father's name on character template.

					mov	byte [character.father.l], cl							; Store length of father's name in character template.
					repnz	movsb										; Store father's name in character template.

					pop	esi										; Restore index to socket entry.

					mov	ebp, 00000001h									; ebp - current area id.

build.pouch:				push	esi										; Preserve index to socket entry.

					mov	ebx, area.filename								; ebx - Pointer to filename for area to be created.
					call	open.descriptor									; Attempt to associate a descriptor with the file.

					or	eax, eax									; Were we able to associate a descriptor with the filename?
					js	build.pouch.found.open.id							; No. We've found an open id to use - let's go use it.
					
					mov	ebx, eax									; Yes. Let's close it up so we can search the next id up the
																; ladder. ebx - descriptor to be disassociated.
					call	close.descriptor								; Disassociate that descriptor.

					inc	ebp										; ebp - next area id to check.
					mov	esi, area.filename+id.size							; esi - pointer to area filename.

					jmp	area.filename.increment.cmp							; Go see if we've traversed the entire filename.

build.pouch.increment.byte:		inc	byte [esi]									; No. Increment the byte.

					jmp	build.pouch									; Try the new area id.

area.filename.next.digit.increment:	mov	byte [esi], 00h									; Zero the current byte...
					dec	esi										; Move up the filename to the next byte...

area.filename.increment.cmp:		cmp	esi, area.filename-1								; Have we traversed the entire filename?
					jz	area.filename.out.of.ids							; Yes. Go display an error on local and remote terminals and
																; disconnect the socket.

					cmp	byte [esi], 39h									; Is the byte a 9?
					jz	area.filename.next.digit.increment						; Yes. Zero it and move up the filename to the next digit.

					jmp	build.pouch.increment.byte							; No. Increment the byte and try the next id.

area.filename.out.of.ids:		pop	esi										; esi - Index to socket entry.

					mov	eax, [esi+connection.descriptor.index]						; eax - Descriptor associated with current connected socket.

					mov	dword [socket.data.send.socket.descriptor], eax					; Store socket descriptor for send function.
					mov	dword [socket.data.send.buffer.pointer], socket.data.out.of.area.ids.message	; Point send function to message indicating that we're fresh out
																; of area ids.
					mov	dword [socket.data.send.buffer.l], socket.data.out.of.area.ids.message.l	; Store length of message for send function.
					call	socket.send									; Send the message on the socket.

					call	clean.socket									; Disconnect the current socket.

					mov	ecx, local.data.out.of.area.ids.message						; ecx - Pointer to local message indicating that we're fresh out
																; of area ids.
					mov	edx, local.data.out.of.area.ids.message.l					; edx - Length of message.
					call	write.descriptor								; Tell the admin that we're fresh out of area ids.

					ret											; Return to caller.

build.pouch.found.open.id:		mov	eax, egg.area.id								; eax - area id associated with egg.
					mov	ecx, egg.hatch.message								; ecx - pointer to message indicating that the egg is about to hatch.
					mov	edx, egg.hatch.message.l							; edx - length of message.
					call	send.to.area									; Tell the area where the egg is sitting that the egg is
																; beginning to hatch.
			
					pop	esi										; esi - Index to socket entry.

					mov	dword [character.pouch], ebp							; Store area id for character pouch.
					mov	ebx, area.filename								; ebx - pointer to file to be created for character pouch.
					call	create.file									; create the file.

					push	eax										; Store descriptor associated with new pouch.

					sub	al, al										; al - prepared for use as counter.

					push	esi										; Preserve index to socket entry.

					add	esi, connection.filename.index							; esi - pointer to socket filename.
					mov	edi, area.name									; edi - pointer to buffer for area name.
					
build.pouch.area.name:			movsb											; store a byte of the filename.
					inc	al										; add a byte to the size of the filename.

					cmp	byte [esi], 00h									; Have we reached the end of the filename?
					jnz	build.pouch.area.name								; Nope. Go store the rest of the filename.

					add	al, pouch.declaration.l								; al - length of filename+length of pouch declaration.
					
					mov	byte [area.name.l], al								; store length of filename+length of pouch declaration.
					mov	esi, pouch.declaration								; esi - pointer to pouch declaration.
					mov	ecx, pouch.declaration.l							; ecx - length of pouch declaration.
					repnz	movsb										; Write pouch declaration to area.name.

					mov	byte [area.description.l], pouch.description.l					; Store length of pouch description.
					mov	esi, pouch.description								; esi - pointer to pouch description.
					mov	edi, area.description								; edi - pointer to storage for are description.
					mov	ecx, pouch.description.l							; ecx - length of pouch description.
					repnz	movsb										; Write pouch description to storage for area description.

					pop	esi										; Restore index to socket entry.
					pop	ebx										; Restore descriptor associated with pouch.

					mov	ecx, area.header								; ecx - pointer to area header.
					mov	edx, area.header.l								; edx - length of area header.
					call	write.descriptor								; Write area header for pouch to area file.

					call	close.descriptor								; Disassociate the descriptor with the area file.

					call	dna.lab										; Figure up the DNA for the new Gylf.

					mov	ebx, esi									; ebx - Index to socket table.
					add	ebx, connection.filename.index							; ebx - pointer to filename associated with active connection.
					call	create.file									; Smoke the egg and create a new file.

					push	eax										; Preserve descriptor associated with new file.

					mov	[file.indicator], eax								; Point write function to new file.
					mov	ecx, buffer.2									; ecx - pointer to length of passphrase data.
					mov	edx, dword.l									; edx - length of passphrase data.
					call	write.descriptor								; Write length of passphrase data to new file.

					pop	eax										; Restore descriptor associated with new file.
					push	eax										; Preserve descriptor associated with new file.

					mov	[file.indicator], eax								; Point write function to new file.
					mov	ecx, buffer.1									; ecx - pointer to received passphrase data.
					mov	edx, dword [buffer.2]								; edx - length of passphrase data.
					call	write.descriptor								; Write passphrase data to new file.

					pop	eax										; Restore descriptor associated with new file.
					push	eax										; Preserve descriptor associated with new file.

					mov	[file.indicator], eax								; Point write function to new file.
					mov	ecx, character.data								; ecx - pointer to generated character data.
					mov	edx, character.data.l								; edx - length of character data.
					call	write.descriptor								; Write character data to new file.

					pop	eax										; Restore descriptor associated with new file.
					call	close.descriptor								; Disassociate descriptor.
			
					ret											; Return to caller.
