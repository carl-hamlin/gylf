;================================================================================================================================================================================================
;
;   create.lock.file
;
;   This function builds a lock file to prevent multiple instances of the same login.
;
;   Assumptions:    ebp - Size of received data.
;
;   Returns:        None.
;

    create.lock.file: pusha                       ; Preserve caller registers.
                      mov   esi, lock.extension   ; esi - Pointer to lock extension.
                      mov   edi, buffer.1         ; edi - Pointer to received character data file name.
                      add   edi, ebp              ; edi - Pointer to end of received character data file name.
                      push  edi                   ; Store pointer to end of received character data file name.
                      mov   ecx, lock.extension.l ; ecx - Length of lock extension.
                      repnz movsb                 ; Tack the extension onto the file name.

                      mov   ebx, buffer.1         ; ebx - Pointer to lock file name.
                      call  create.file           ; Create the lock file.

                      mov   ebx, eax              ; ebx - Descriptor associated with lock file.
                      call  close.descriptor      ; Disassociate the descriptor.

                      sub   al, al                ; al - Zeroes for smoking the extension.
                      pop   edi                   ; Restore pointer to end of received character data file name.
                      mov   ecx, lock.extension.l ; ecx - Length of lock extension.
                      repnz stosb                 ; Smoke the extension.

                      popa                        ; Restore caller's registers.

                      ret                         ; Return to caller.
