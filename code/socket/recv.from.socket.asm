;=================================================================================================================================================================================================
;
;   recv.from.socket
;
;   This function receives data from a connected socket and places it in a specified buffer.
;
;   Assumptions:    esi = Index to connection tables.
;
;   Returns:        None.

recv.from.socket:   mov     eax, dword [esi+connection.descriptor.index]        ; eax = Descriptor associated with target socket.
                    mov     dword [socket.data.send.socket.descriptor], eax     ; Point recv.from.socket to target socket.
                    mov     dword [socket.data.send.buffer.pointer], buffer.1   ; Point recv.from.socket to data buffer.
                    mov     dword [socket.data.send.buffer.l], buffer.1.l       ; Provide length of buffer.

                    mov     eax, sys.socket.call                                ; eax = Socket call indicator.
                    mov     ebx, sys.socket.recv                                ; ebx = Receive from socket.
                    mov     ecx, socket.data.send.socket.descriptor             ; ecx = Pointer to arguments package.
                    int     sys.system.call                                     ; Receive from socket.

                    ret                                                         ; Return to caller.
