;=================================================================================================================================================================================================
;
;   print.socket.number
;
;   This function prints a socket number for the admin.
;
;   Assumptions:    esi - Index to socket entry.
;
;   Returns:        None.
;

    print.socket.number: pusha                             ; Preserve caller registers.

                         mov  ecx, esi                     ; ecx - index to socket entry.
                         add  ecx, connection.number.index ; ecx - pointer to socket number.
                         mov  edx, dword.l                 ; edx - size of socket number.
                         call write.descriptor             ; Write the socket number locally.

                         popa                              ; Restore caller registers.

                         ret                               ; Return to caller.
