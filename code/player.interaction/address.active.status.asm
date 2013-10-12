;==========================================================================================================================================================================================================================================================================================================================
;
;   address.active.status
;
;   This function performs further processing on data submitted by a socket with status 'active'.
;
;   Assumptions:    esi = Pointer to descriptor associated with target socket.
;
;   Returns:        None.
;

address.active.status:                      call    recv.from.socket                                                        ; Get the data from the socket.

                                            mov     ebx, buffer.1                                                           ; ebx = Pointer to received data.
                                            call    buffer.strip                                                            ; Strip extra characters from the received data.

                                            mov     ecx, number.of.commands                                                 ; ecx - Number of commands in command table. This number acts as our loop counter.

                                            push    esi                                                                     ; Preserve index to socket entry.
                                            push    edi                                                                     ; Preserve caller's edi register.

                                            mov     esi, command.table                                                      ; esi - Index to command table.
                                            mov     edi, ebx                                                                ; edi - Pointer to received data.

address.active.status.read.command.table:   push    ecx                                                                     ; Preserve loop counter.
                                            sub     ecx, ecx                                                                ; ecx - Prepared to be used as string length indicator.
                                            mov     cl, byte [esi]                                                          ; cl - length of command in table.
                                            inc     esi                                                                     ; esi - Pointer to string data corresponding to command currently being
                                                                                                                            ; referenced in the table.

                                            cmp     cl, al                                                                  ; Is the length of the received data at least the same as the command in the table?
                                            ja      address.active.status.next.command                                      ; No. It's not necessary to perform any further comparison; the received data cannot possibly refer to the command currently being read from the table. Move on to the next table entry.

                                            repz    cmpsb                                                                   ; Check to see if the received data is the same as the string data corresponding to the command currently being referenced in the table.
                                            jcxz    address.active.status.found.command                                     ; Did we get all the way through the string before cmpsb cut us loose? If
                                                                                                                            ; so, go set up the handler and jump to it.

                                            jmp     address.active.status.next.command.jcxnz                                ; Otherwise, go set up for the next iteration.

address.active.status.found.command:        pop     ecx                                                                     ; Restore loop counter.
                                            pop     edi                                                                     ; Restore caller's edi register...

                                            mov     ebx, dword [esi]                                                        ; ebx - Pointer to handler for command.
                                            pop     esi                                                                     ; esi - Index to socket entry.

                                            jmp     ebx                                                                     ; Jump to handler for command.

address.active.status.next.command.jcxnz:   sub     edx, ecx                                                                ; edx - number of bytes received minus the number of bytes run through by cmpsb before a mismatch was discovered.
                                            mov     edi, ebx                                                                ; edi - Pointer to received data.

address.active.status.next.command:         add     esi, ecx                                                                ; esi - Pointer to handler for command currently being referenced in the table.
                                            add     esi, dword.l                                                            ; esi - Pointer to size of next command in the table.
                                            pop     ecx                                                                     ; Restore loop counter.
                                            loop    address.active.status.read.command.table                                ; Go check the next command.

                                            pop     edi                                                                     ; Restore caller's edi register.
                                            pop     esi                                                                     ; esi - Index to socket entry.

                                            mov     ebx, dword [esi+connection.descriptor.index]                            ; ebx - descriptor associated with current active socket.

                                            mov     dword [socket.data.send.socket.descriptor], ebx                         ; Store socket descriptor for send function.
                                            mov     dword [socket.data.send.buffer.pointer], socket.data.bad.command.error  ; Point send function to message indicating that the command was bad.
                                            mov     dword [socket.data.send.buffer.l], socket.data.bad.command.error.l      ; Store length of message for send function.
                                            call    socket.send                                                             ; Tell the user that the command doesn't have a current analogue.

                                            mov     eax, dword [esi+connection.descriptor.index]                            ; eax - descriptor associated with current active socket.
                                            call    write.prompt                                                            ; Give the user a command prompt.

                                            ret                                                                             ; Return to caller.
