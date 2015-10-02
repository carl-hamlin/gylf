;====================================================================================================================================================================================================
;
;   socket.send
;
;   This function sends data out on a connected socket.
;
;   Assumptions:    No register assumptions, however the arguments packaged referred to herein by the ecx register must be properly packed before calling. The package is structured as follows:
;
;                   dword    Descriptor associated with target socket.
;                   dword    Pointer to data to be sent.
;                   dword    Length of data to be sent.
;                   dword    Communications semantics.
;
;   Returns:        None.
;

    socket.send: push ecx                                     ; Preserve caller's ecx register.
                 mov  eax, sys.socket.call                    ; eax = Socket call indicator.
                 mov  ebx, sys.socket.send                    ; ebx = Send data out on a socket.
                 mov  ecx, socket.data.send.socket.descriptor ; ecx = Pointer to arguments package for send function.
                 int  sys.system.call                         ; Send data out on a socket.
                 pop  ecx                                     ; Restore caller's ecx register.

                 ret                                          ; Return to caller.
