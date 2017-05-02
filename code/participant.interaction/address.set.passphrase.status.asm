;=================================================================================================================================================================================================
;
;   ./functions/main/participant.interaction/address.set.passphrase.status/t
;
;   This function handles data received from a socket in 'setting passphrase' status.
;
;   Assumptions:    esi = Pointer to descriptor associated with target socket
;
;   Returns:        None.
;

	address.set.passphrase.status:	call	recv.from.socket					                        ; Receive data from the active socket.

					                        mov	  dword [buffer.2], eax					                    ; Store number of bytes received for later use.

					                        mov	  ebx, esi						                              ; ebx - Pointer to socket entry.
					                        add	  ebx, connection.filename.index				            ; ebx - Pointer to file path for user's credential file.
					                        call	open.descriptor						                        ; Associate a descriptor with the file.

					                        mov	  eax, dword [esi+connection.descriptor.index]      ; eax - Descriptor associated with egg file.
					                        call	create.character					                        ; Build out the character.

					                        mov	  byte [esi+connection.status.index], active.status ; Set socket status to 'active'.

	                                ; *** Here's where particpants begin to integrate. ***

					                        call	write.welcome						                          ; Set up the user screen.

					                        ret								                                      ; Return to caller.
