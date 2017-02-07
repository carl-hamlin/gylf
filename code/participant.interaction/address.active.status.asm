;==========================================================================================================================================================================================================================================================================================================================
;
;   address.active.status
;
;   This function performs further processing on data submitted by a socket with status 'active'.
;
;   Assumptions:    eax = Length of received data.
;                   esi = Pointer to descriptor associated with target socket.
;
;   Returns:        None.
;

    address.active.status:                    int 3
    call  recv.from.socket                          ; Get the data from the socket.
                                              call  aggregate.arguments                       ; Aggregate arguments received.

                                              mov   ecx, number.of.commands                   ; ecx - Number of commands in command table. This number acts as our loop counter.

                                              push  esi                                       ; Preserve index to socket entry.
                                              push  edi                                       ; Preserve caller's edi register.

                                              mov   edi, ebx                                  ; edi - Pointer to received data.
                                              mov   edx, ebx                                  ; edx - Permanent pointer to received data.
                                              mov   ebx, command.table                        ; ebx - Index to command table.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    address.active.status.read.command.table: push  ecx                                       ; Preserve loop counter.
                                              sub   ecx, ecx                                  ; ecx - Prepared to be used as string length indicator.
                                              mov   esi, dword [ebx]                          ; esi - Pointer to command length.
                                              mov   cl, byte [esi]                            ; cl - length of command in table.
                                              inc   esi                                       ; esi - Pointer to string data corresponding to command currently being referenced in the table.

                                              cmp   cl, al                                    ; Is the length of the received data at least the same as the command in the table?
                                              ja    address.active.status.next.command        ; No. It's not necessary to perform any further comparison; the received data cannot possibly refer to the command currently being read from the table. Move on to the next table entry.

                                              repz  cmpsb                                     ; Check to see if the received data is the same as the string data corresponding to the command currently being referenced in the table.
                                              jnz   address.active.status.next.command.jcxnz  ; Otherwise, go set up for the next iteration.
                                              jcxz  address.active.status.found.command       ; Did we get all the way through the string before cmpsb cut us loose? If so, go set up the handler and jump to it.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    address.active.status.found.command:      pop   ecx                                       ; Restore loop counter.
                                              pop   edi                                       ; Restore caller's edi register...

                                              mov   ebx, dword [esi]                          ; ebx - Pointer to handler for command.
                                              pop   esi                                       ; esi - Index to socket entry.

                                              jmp   ebx                                       ; Jump to handler for command.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    address.active.status.next.command.jcxnz: mov   edi, edx                                  ; edi - Pointer to received data.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    address.active.status.next.command:       add   ebx, dword.l                              ; ebx - pointer to next table entry.
                                              pop   ecx                                       ; Restore loop counter.
                                              loop  address.active.status.read.command.table  ; Go check the next command.

                                              pop   edi                                       ; Restore caller's edi register.
                                              pop   esi                                       ; esi - Index to socket entry.

                                              call  write.bad.command.error                   ; Let the user know that they've entered a bad command and suggest that they try HELP.

                                              ret                                             ; Return to caller.
