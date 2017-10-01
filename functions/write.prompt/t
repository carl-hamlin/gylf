;====================================================================================================================================================================================================
;
;   write.prompt
;
;   This function prints a command prompt.
;
;   Assumptions:    eax - Descriptor associated with target connection.
;
;   Returns:        None.
;

    write.prompt: mov  dword [socket.data.send.socket.descriptor], eax         ; Point socket.send to target connection.
                  mov  dword [socket.data.send.buffer.pointer], prompt.message ; Point socket.send to prompt message.
                  mov  dword [socket.data.send.buffer.l], prompt.message.l     ; Provide length of message.
                  call socket.send                                             ; Send the welcome message to the socket.

                  ret                                                          ; Return to caller.
