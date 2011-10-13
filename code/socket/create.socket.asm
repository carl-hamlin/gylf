;=================================================================================================================================================================================================
;
;	create.socket
;
;	This function builds a socket for further use.
;
;	Assumptions:	None.
;
;	Returns:	eax = Error indicator.
;

create.socket:	mov	dword [socket.data.protocol.family], sys.socket.protocol.family.inet	; Set protocol family.
		mov	dword [socket.data.flags], sys.socket.type.stream			; Set flags.
		mov	dword [socket.data.address], sys.socket.address				; Set address.

		mov	eax, sys.socket.call							; eax = Socket call indicator.
		mov	ebx, sys.socket.create							; ebx = Create a socket.
		mov	ecx, socket.data.protocol.family					; ecx = Pointer to arguments package.
		int	sys.system.call								; Create a socket.

		ret										; Return to caller.
