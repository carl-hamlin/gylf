;====================================================================================================================================================================================================
;
;	listen.socket
;
;	This function tells a created and bound socket to listen for incoming connections.
;
;	Assumptions:	None.
;
;	Returns:	eax = Error indicator.
;

listen.socket:	mov	dword [socket.data.queue.l], sys.socket.queue.l	; Set the queue length.

		mov	eax, sys.socket.call				; eax = Socket call indicator.
		mov	ebx, sys.socket.listen				; ebx = Tell the socket to listen.
		mov	ecx, socket.data.listening.socket.descriptor	; ecx = Pointer to arguments package for the listen function.
		int	sys.system.call					; Tell the socket to listen.

		ret							; Return to caller.
