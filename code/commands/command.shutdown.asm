;====================================================================================================================================================================================================
;
;   command.shutdown.asm
;
;   This function shuts down the server from within the environment.
;
;   Assumptions:    esi - Index to active socket entry.
;
;   Returns:        None.
;

command.shutdown:       call    check.admin                                                             ; See if the calling socket is controlled by an admin.
                        jc      command.shutdown.admin                                                  ; If so, go run the shutdown sequence. Otherwise...

                        mov     ebx, dword [esi+connection.descriptor.index]                            ; ebx - Descriptor associated with current connection.
                        mov     dword [socket.data.send.socket.descriptor], ebx                         ; Store socket descriptor for send function. 
                        mov     dword [socket.data.send.buffer.pointer], socket.data.bad.command.error  ; Point send function to message indicating that the command was bad.
                        mov     dword [socket.data.send.buffer.l], socket.data.bad.command.error.l      ; Store length of message for send function.
                        call    socket.send                                                             ; Tell the user that the command doesn't have a current analogue.

                        ret                                                                             ; Return to caller.

command.shutdown.admin: mov     ecx, socket.data.shutdown.message                                       ; ecx - Pointer to socket shutdown message.
                        mov     edx, socket.data.shutdown.message.l                                     ; edx - Length of message.
                        call    send.to.world                                                           ; Send the shutdown message to the world.

                        mov     ecx, local.data.shutdown.message                                        ; ecx - Pointer to message indicating that shutdown has been initiated from within the
                                                                                                        ; environment.
                        mov     edx, local.data.shutdown.message.l                                      ; edx - Length of message.
                        call    write.descriptor                                                        ; Let the admin know that shutdown has been initiated from within the environment.

                        mov     esi, connection.table                                                   ; esi - Pointer to command table.
                        mov     ecx, socket.number                                                      ; ecx - Number of sockets to smoke.

command.shutdown.loop:  call    clean.socket                                                            ; Smoke the current socket.
                        add     esi, connection.entry.size                                              ; esi - Pointer to next victim.
                        loop    command.shutdown.loop                                                   ; Go smoke the rest of the sockets.

                        mov     ecx, local.data.smoked.sockets.message                                  ; Pointer to message indicating all sockets have been smoked.
                        mov     edx, local.data.smoked.sockets.message.l                                ; Length of message.
                        call    write.descriptor                                                        ; Let the admin know all sockets have been smoked.

                        jmp     bail                                                                    ; Unload from memory and return control to Linux.
