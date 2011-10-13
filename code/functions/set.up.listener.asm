;=================================================================================================================================================================================================
;
;	set.up.listener
;
;	This function builds a socket, binds it to a specified hardware port, and tells it to listen for incoming connections. When it's finished, it displays a message to the admin indicating
;	that we're online and ready to go. If at any point an error occurs, the function displays an error message and passes control to the bail function so we can suspend execution and return
;	control to linux in the hopes that the admin can figure out what's clogging up the works.
;
;	Assumptions:	None.
;
;	Returns:	None, although it is assumed that if the function returns at all, a listening socket will have been established.

set.up.listener:	call	create.socket				; Create the socket we're going to be using to listen for incoming connections.

			or	eax, eax				; If the socket creation process failed, or'ing eax against itself will produce a negative number, with a sign. We can use
			jns	socket.bind				; that sign to determine if an error occured. If it didn't, then we'll move on to binding the socket to a port.

			jmp	socket.create.error			; Looks like the socket creation process failed somehow. Go display the error message and return control to linux so the
									; admin can figure out what's up.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

socket.bind:		call	bind.socket				; Bind the socket to a port specified elsewhere.

			or	eax, eax				; If the socket binding process failed, or'ing eax against itself will produce a negative number, with a sign. We can use
			jns	socket.listen				; that sign to determine if an error occurred. If it didn't, then we'll move on to telling the bound socket to start
									; listening for connections.

			jmp	socket.bind.error			; Looks like the socket binding process failed somehow. Go display the error message and return control to linux so the
									; admin can figure out what's up.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

socket.listen:		call	listen.socket				; Tell the socket to start listening for incoming connections.

			or	eax, eax				; If the process of telling the socket to start listening failed, or'ing eax against itself will produce a negative
			jns	socket.display.success			; number, with a sign. We can use that sign to determine whether or not an error occurred. If it didn't, we'll tell the
									; admin the socket is ready and hop into the main loop.

			jmp	socket.listen.error			; Looks like the process of telling the socket to listen failed somehow. Go display the error message and return control
									; to linux so the admin can figure out what's up.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

socket.display.success:	mov	ecx, local.data.listening.message	; ecx = Pointer to message indicating the socket has been established.

			mov	edx, local.data.listening.message.l	; edx = Length of message.
			call	write.descriptor			; Tell the admin the socket has been established.

			ret						; Return to caller.
