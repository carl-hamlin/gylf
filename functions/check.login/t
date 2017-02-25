;================================================================================================================================================================================================
;
;   check.login
;
;   This function checks to see if a participant attempting to log in is already logged in.
;
;   Assumptions:    eax - number of bytes received after strip.
;                   ebx - Pointer to received participant data file name.
;
;   Returns:        None.
;

    check.login:        pusha                                 ; Preserve all caller registers.

                        mov   esi, ebx                        ; esi - pointer to received participant data file name.
                        mov   edi, buffer.2                   ; edi - pointer to secondary buffer.
                        mov   ecx, eax                        ; ecx - length of participant data file name.
                        repnz movsb                           ; Store participant data file name in secondary buffer.
                        mov   [edi], ah                       ; Zero terminate participant data file name.

                        mov   esi, current.directory.marker   ; esi - pointer to current directory marker.
                        mov   edi, buffer.1                   ; edi - pointer to primary buffer.
                        mov   ecx, current.directory.marker.l ; ecx - length of current.directory.marker.
                        repnz movsb                           ; Tack current directory marker onto the front of the participant data file name.

                        mov   esi, buffer.2                   ; esi - pointer to secondary buffer
                        mov   ecx, eax                        ; ecx - length of participant data file name.
                        repnz movsb                           ; Place participant data file name behind current directory marker.

                        mov   esi, lock.extension             ; esi - Pointer to extension for lock files.
                        mov   edi, ebx                        ; edi - Pointer to received participant data file name.
                        add   edi, current.directory.marker.l ; edi - pointer to end of current directory marker.
                        add   edi, eax                        ; edi - Pointer to end of received participant data file name.
                        push  edi                             ; Store pointer to end of received participant data file name.
                        mov   ecx, lock.extension.l           ; ecx - Length of extension for lock files.
                        repnz movsb                           ; Tack lock extension on to the end of the file name.

                        mov   ebx, buffer.1                   ; ebx - Pointer to lock file name.
                        call  open.descriptor                 ; Attempt to associate a descriptor with the file name. If the file exists and is associable, then the participant is logged in.

                        or    eax, eax                        ; Check to see if eax contains an error code. If it does, we weren't able to associate a descriptor with the lock file, indicating that the corresponding character is not logged in.
                        jns   check.login.logged              ; If it doesn't, however, the lock file exists, and we need to bounce this connection.

                        pop   edi                             ; Restore pointer to end of received character data file name.
                        sub   al, al                          ; al - Zeroes for clearing lock extension.
                        mov   ecx, lock.extension.l           ; ecx - Length of lock extension.
                        repnz stosb                           ; Clear the lock extension.

                        popa                                  ; Restore all caller registers.

                        clc                                   ; Clear the carry flag.

                        ret                                   ; Return to caller.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    check.login.logged: mov   ebx, eax                        ; ebx - Descriptor associated with lock file.
                        call  close.descriptor                ; Disassociate the descriptor.

                        pop   edi                             ; Restore pointer to end of received character data file name.
                        sub   al, al                          ; al - Zeroes for clearing lock extension.
                        mov   ecx, lock.extension.l           ; ecx - Length of lock extension.
                        repnz stosb                           ; Clear the lock extension.

                        popa                                  ; Restore all caller registers.

                        stc                                   ; Set the carry flag.

                        ret                                   ; Return to caller.
