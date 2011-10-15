;================================================================================================================================================================================================
;
;   check.login
;
;   This function checks to see if a character attempting to log in is already logged in.
;
;   Assumptions:    eax - number of bytes received after strip.
;                   ebx - Pointer to received character data file name.
;
;   Returns:        None.
;

check.login:        pusha                           ; Preserve all caller registers.
                    mov     esi, lock.extension     ; esi - Pointer to extension for lock files.
                    mov     edi, ebx                ; edi - Pointer to received character data file name.
                    add     edi, eax                ; edi - Pointer to end of received character data file name.
                    push    edi                     ; Store pointer to end of received character data file name.
                    mov     ecx, lock.extension.l   ; ecx - Length of extension for lock files.
                    repnz   movsb                   ; Tack lock extension on to the end of the file name.

                    mov     ebx, buffer.1           ; ebx - Pointer to lock file name.
                    call    open.descriptor         ; Attempt to associate a descriptor with the file name. If the file exists and is associable, then the character is logged in.

                    or      eax, eax                ; Check to see if eax contains an error code. If it does, we weren't able to associate a descriptor with the lock file, indicating that
                                                    ; the corresponding character is not logged in.
                    jns     check.login.logged      ; If it doesn't, however, the lock file exists, and we need to bounce this connection.

                    pop     edi                     ; Restore pointer to end of received character data file name.
                    sub     al, al                  ; al - Zeroes for clearing lock extension.
                    mov     ecx, lock.extension.l   ; ecx - Length of lock extension.
                    repnz   stosb                   ; Clear the lock extension.

                    popa                            ; Restore all caller registers.

                    clc                             ; Clear the carry flag.

                    ret                             ; Return to caller.

check.login.logged: mov     ebx, eax                ; ebx - Descriptor associated with lock file.
                    call    close.descriptor        ; Disassociate the descriptor.

                    pop     edi                     ; Restore pointer to end of received character data file name.
                    sub     al, al                  ; al - Zeroes for clearing lock extension.
                    mov     ecx, lock.extension.l   ; ecx - Length of lock extension.
                    repnz   stosb                   ; Clear the lock extension.

                    popa                            ; Restore all caller registers.

                    stc                             ; Set the carry flag.

                    ret                             ; Return to caller.
