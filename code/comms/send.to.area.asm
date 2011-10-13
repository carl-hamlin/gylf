;====================================================================================================================================================================================================
;
;	send.to.area
;
;	This function sends a provided message out to a provided area.
;
;	Assumptions:	eax - Area id to be broadcast.
;			ecx - Pointer to message to be broadcast.
;			edx - Length of message to be broadcast.
;
;	Returns:	None.
;

send.to.area:			push	esi						; Preserve caller's esi.

				mov	dword [socket.data.send.buffer.pointer], ecx	; Point send function to provided message.
				mov	dword [socket.data.send.buffer.l], edx		; Provide length of message to send function.

				mov	esi, connection.table				; esi - pointer to table of handles associated with active connections.
				mov	ecx, socket.number				; ecx - number of connections to poll.

send.to.area.connection.poll:	cmp	dword [esi+connection.descriptor.index], eax	; Does the area id associated with this connection match the area id to be broadcast?
				jz	send.to.area.broadcast				; Yes. Go broadcast to this connection.

send.to.area.broadcast.done:	add	esi, connection.entry.size			; esi - pointer to next connection handle in table.
				loop	send.to.area.connection.poll			; Go check the next connection.

				pop	esi						; Restore caller's esi.

				ret							; Return to caller.

send.to.area.broadcast		push	eax						; Preserve area id to be broadcast.
				mov	eax, dword [esi+connection.descriptor.index]	; eax - descriptor to be broadcast to.
				mov	dword [socket.data.send.socket.descriptor], eax ; Point send function to descriptor to which the message is to be sent.
				pop	eax						; Restore area id to be broadcast.
				call	socket.send					; Send the message to the indicated descriptor.

				jmp	send.to.area.broadcast.done			; Go set up for the next connection.
