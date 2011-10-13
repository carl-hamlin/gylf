;====================================================================================================================================================================================================
;
;	send.to.world
;
;	This function sends a provided message out to the whole world.
;
;	Assumptions:	ecx - Pointer to message to be broadcast.
;			edx - Length of message to be broadcast.
;
;	Returns:	None.
;

send.to.world:		push	esi									; Preserve caller's esi register.

			mov	dword [socket.data.send.buffer.pointer], ecx				; Point send function to provided message.
			mov	dword [socket.data.send.buffer.l], edx					; Provide length of message to send function.

			mov	esi, connection.table							; esi - Index to socket entries.
			mov	ecx, socket.number							; ecx - Number of sockets in table; we use this number as our loop counter.

send.to.world.loop:	push	eax									; Preserve caller's eax register.
			mov	eax, dword [esi+connection.descriptor.index]				; eax - Descriptor associated with socket to be broadcast.
			mov	dword [socket.data.send.socket.descriptor], eax				; Point send function to the socket to be broadcast.
			pop	eax									; Restore caller's eax register.
			call	socket.send								; Send the message to the socket.

			push	ecx									; Preserve loop counter.

			mov	ecx, dword [socket.data.send.buffer.pointer]				; ecx - Provided message.

			mov	dword [socket.data.send.buffer.pointer], local.data.carriage.return	; Point send function to the carriage return.
			mov	dword [socket.data.send.buffer.l], local.data.carriage.return.l		; Provide the length of the carriage return.
			call	socket.send								; Broadcast a carriage return.

			mov	dword [socket.data.send.buffer.pointer], ecx				; Point send function to provided message.
			mov	dword [socket.data.send.buffer.l], edx					; Provide length of message to send function.

			pop	ecx									; Restore loop counter.

			push	eax									; Preserve caller's eax register.
			mov	eax, dword [esi+connection.descriptor.index]				; eax - Descriptor associated with active socket.
			call	write.prompt								; Send a prompt.
			pop	eax									; Restore caller's eax register.

			add	esi, connection.entry.size						; esi - Pointer to next descriptor in table.
			loop	send.to.world.loop							; Go broadcast to the next socket in the table.

			pop	esi									; Restore caller's esi register.

			ret										; Return to caller.
