;=================================================================================================================================================================================================
;
;   system.check
;
;   This code performs checks to ensure the system is ready to go live.
;
;   Assumptions:    None.
;
;   Returns:        None.
;

    system.check:                                  mov  ecx, local.data.system.check.message                       ; ecx - Pointer to message indicating system check underweigh
                                                   mov  edx, local.data.system.check.message.l                     ; edx - Length of message
                                                   call write.descriptor                                           ; Tell the admin that a system check is underweigh

                                                   mov  ecx, local.data.populating.connection.table.message        ; ecx - Pointer to message indicating that system check is populating the connection numbers table.
                                                   mov  edx, local.data.populating.connection.table.message.l      ; edx - Length of message.
                                                   call write.descriptor                                           ; Let the admin know that system.check is populating the connection numbers table.

                                                   mov  esi, socket.numbers                                        ; esi - Pointer to placeholder for socket numbers.
                                                   mov  edi, connection.table                                      ; edi - Index into connection table.
                                                   add  edi, connection.number.index                               ; edi - Pointer to first connection number to be populated.
                                                   mov  ecx, socket.number                                         ; ecx - Number of sockets to number. Used as loop counter.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    system.check.populate.connection.numbers.loop: movsd                                                           ; Copy the current socket number to the current socket number table entry.

                                                   sub  esi, dword.l                                               ; Restore esi to its pre-movsd value.
                                                   sub  edi, dword.l                                               ; Restore edi to its pre-movsd value.

                                                   add  edi, connection.entry.size                                 ; edi - Pointer to next socket number table entry.
                                                   mov  ebx, esi                                                   ; ebx - Pointer to placeholder for socket numbers.
                                                   add  ebx, socket.numbers.l                                      ; ebx - Pointer to byte immediately following placeholder for socket numbers.
                                                   dec  ebx                                                        ; ebx - Pointer to last byte of placeholder for socket numbers.

                                                   cmp  byte [ebx], char.9                                         ; Is the byte at [ebx] "9"?
                                                   jz   system.check.populate.connection.numbers.0010              ; Yes. Go zero it out and address the next place up.

                                                   inc  byte [ebx]                                                 ; No. Increment the byte.
                                                   loop system.check.populate.connection.numbers.loop              ; Go store this entry.

                                                   jmp  system.check.populate.connection.numbers.done              ; We're done here, so go finish up with system.check.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    system.check.populate.connection.numbers.0010: mov  byte [ebx], char.0                                         ; Zero the byte at [ebx].
                                                   dec  ebx                                                        ; ebx - Pointer to byte representing the next place up.

                                                   cmp  byte [ebx], char.9                                         ; Is the byte at [ebx] a "9"?
                                                   jz   system.check.populate.connection.numbers.0100              ; Yes. Go zero it out and address the next place up.

                                                   inc  byte [ebx]                                                 ; No. Increment the byte.
                                                   loop system.check.populate.connection.numbers.loop              ; Go store this entry.

                                                   jmp  system.check.populate.connection.numbers.done              ; We're done here, so go finish up with system.check.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    system.check.populate.connection.numbers.0100: mov  byte [ebx], char.0                                         ; Zero the byte at [ebx].
                                                   dec  ebx                                                        ; ebx - Pointer to byte representing the next place up.

                                                   cmp  byte [ebx], char.9                                         ; Is the byte ate [ebx] a "9"?
                                                   jz   system.check.populate.connection.numbers.1000              ; Yes. Go zero it out and address the next place up.

                                                   inc  byte [ebx]                                                 ; No. Increment the byte.
                                                   loop system.check.populate.connection.numbers.loop              ; Go store this entry.

                                                   jmp  system.check.populate.connection.numbers.done              ; We're done here, so go finish up with system.check.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    system.check.populate.connection.numbers.1000: mov  byte [ebx], char.0                                         ; Zero the byte at [ebx].
                                                   dec  ebx                                                        ; ebx - Pointer to byte representing the next place up.

                                                   cmp  byte [ebx], char.9                                         ; Is the byte at [ebx] a "9"?
                                                   jz   system.check.populate.connection.numbers.over              ; Yes. At this point, we're experiencing a bounds error, so go tell the admin we're fucked and shut down the server.

                                                   inc  byte [ebx]                                                 ; No. Increment the byte.
                                                   loop system.check.populate.connection.numbers.loop              ; Go store this entry.

                                                   jmp  system.check.populate.connection.numbers.done              ; We're done here, so go finish up with system.check/

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    system.check.populate.connection.numbers.over: mov  ecx, local.data.populate.connection.numbers.over.message   ; ecx - Pointer to message indicating we experienced a bounds error and need to shut down the server.
                                                   mov  edx, local.data.populate.connection.numbers.over.message.l ; Length of message.
                                                   call write.descriptor                                           ; Tell the admin we experienced a bounds error and need to shut down the server.

                                                   jmp  bail                                                       ; Go shut down the server.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    system.check.populate.connection.numbers.done: mov  ecx, local.data.system.check.done                          ; ecx - Pointer to message indicating system check is complete.
                                                   mov  edx, local.data.system.check.done.l                        ; edx - Length of message.
                                                   call write.descriptor                                           ; Tell the admin that the system check is complete.

                                                   ret                                                             ; Return to caller.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
