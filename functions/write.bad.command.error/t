;==========================================================================================================================================================================================================================================================================================================================
;
;   write.bad.command.error
;
;   This function lets the user know that they've entered a bad command and suggests that they try HELP.
;
;   Assumptions:    esi = Pointer to descriptor associated with target socket.
;
;   Returns:        None.
;

    write.bad.command.error:                  mov  ebx, dword [esi+connection.descriptor.index]                           ; ebx - descriptor associated with current active socket.

                                              mov  dword [socket.data.send.socket.descriptor], ebx                        ; Store socket descriptor for send function.
                                              mov  dword [socket.data.send.buffer.pointer], socket.data.bad.command.error ; Point send function to message indicating that the command was bad.
                                              mov  dword [socket.data.send.buffer.l], socket.data.bad.command.error.l     ; Store length of message for send function.
                                              call socket.send                                                            ; Tell the user that the command doesn't have a current analogue.

                                              mov  eax, dword [esi+connection.descriptor.index]                           ; eax - descriptor associated with current active socket.
                                              call write.prompt                                                           ; Give the user a command prompt.

                                              ret                                                                         ; Return to caller.
