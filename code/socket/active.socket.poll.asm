;=================================================================================================================================================================================================
;
;	active.socket.poll
;
;	This function runs through the list of potentially active connections and checks each of them for activity. Upon discovering activity in a connection, the function then passes control
;	off to the answer.active.socket function for more specialized treatment.
;
;	Assumptions:	None.
;
;	Returns:	None.

active.socket.poll:			mov	esi, connection.table					; esi = pointer to table of potentially active connections.
					mov	edi, esi						; edi - Pointer to table of potentially active connections.
					add	edi, connection.status.index				; edi = pointer to table of statii for active connections.
					mov	ecx, socket.number					; ecx = number of connections to check for activity.
					mov	dword [sockets.left], ecx				; Store number of connections to check for activity in memory so we aren't constrained in
													; our use of the ecx register later on.
;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

active.socket.poll.loop:		cmp	dword [esi+connection.descriptor.index], dead.socket	; Are we looking at a dead socket?
					jnz	poll.active.socket					; If not, go see if the socket is active.

poll.active.socket.done:		add	esi, connection.entry.size				; esi = pointer to next socket to check.
					add	edi, connection.entry.size				; edi = pointer to status of next socket.

					loop	active.socket.poll.loop					; Go check the next socket.

					ret								; All sockets checked. Return to caller.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

poll.active.socket			mov	dword [sockets.left], ecx				; Store number of sockets left to check in memory - we're going to need the ecx register
													; for something else momentarily.

					mov	eax, dword [esi+connection.descriptor.index]		; eax - descriptor for active socket.
					mov	dword [socket.data.active.socket.descriptor], eax	; Store descriptor for active socket.
					mov	ebx, socket.data.active.socket.descriptor		; ebx - pointer to descriptor for active socket
					mov	ecx, sys.poll.number.of.structures			; ecx - number of sockets to poll.
					mov	edx, sys.poll.timeout					; edx - length of time to wait on data from the socket.
					call	poll.descriptor						; Poll the socket for activity.

					cmp	eax, sys.poll.in					; Does the socket have data on it waiting for process?
					jz	answer.active.socket					; Yes. Pass control to answer.active.socket for further processing of the discovered data.

					mov	ecx, dword [sockets.left]				; No. Let's get the number of sockets left back into the ecx register so the loop will
													; iterate properly.

					jmp	poll.active.socket.done					; Go check the next socket.

;-----------------------------------------------------------------------------------------------------------------------------------------

active.socket.poll.loop.done:		ret								; All done checking sockets. Pass control back to the caller.
