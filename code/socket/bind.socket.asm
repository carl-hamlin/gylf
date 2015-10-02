;====================================================================================================================================================================================================
;
;   bind.socket
;
;   This function binds the socket to a specified hardware port.
;
;   Assumptions:    eax = Descriptor associated with a created socket.
;
;   Returns:        eax = Error indicator.
;

    bind.socket: mov dword [socket.data.bind.socket.descriptor], eax      ; Store the bind descriptor.
                 mov dword [socket.data.listening.socket.descriptor], eax ; Store the listening descriptor.
                 mov dword [socket.data.event.socket.descriptor], eax     ; Store the event descriptor.
                 mov dword [socket.data.accept.socket.descriptor], eax    ; Store the accept descriptor.

                 mov eax, sys.socket.call                                 ; eax = Socket call indicator.
                 mov ebx, sys.socket.bind                                 ; ebx = Bind the socket.
                 mov ecx, socket.data.bind.socket.descriptor              ; ecx = Pointer to arguments package.
                 int sys.system.call                                      ; Bind the socket.

                 ret                                                      ; Return to caller.
