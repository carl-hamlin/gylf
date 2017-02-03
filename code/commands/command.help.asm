;================================================================================================================================================================================================
;
;   command.help.asm
;
;   This function displays context-sensitive help.
;
;   Assumptions:     eax - Length of received data.
;                    esi - Pointer to descriptor associated with target socket.
;
;   Returns:         None.
;
;   Crossreferences: Location Symbol
;
;                    none     none
;

    command.help:                     int   3
                                      push  eax                             ; Preserve length of received data.
                  
                                      sub   al, al                          ; al - Zero arguments comparator.           
                                      cmp   [arguments.num], al             ; Do we have arguments?
                                      jz    command.help.no.arguments       ; No. Run without the argument parser.
                  
                                      pop   eax                             ; Restore length of received data.
    
                                      push  esi                             ; Preserve caller's esi.
                                      push  edi                             ; Preserve caller's edi.

                                      mov   esi, command.table              ; esi - Index to command table.
                                      mov   edi, [argument.01.location]     ; edi - Pointer to argument.
                  
    command.help.parse.arguments:     push  ecx                             ; Preserve loop counter.
                                      sub   ecx, ecx                        ; ecx - Prepared to be used as string length indicator.
                                      mov   cl, byte [esi]                  ; cl - length of command in table.
                                      inc   esi                             ; esi - Pointer to string data corresponding to command currently being referenced in the table.

                                      cmp   cl, al                          ; Is the length of the received data at least the same as the command in the table?
                                      ja    command.help.next.command       ; No. It's not necessary to perform any further comparison; the received data cannot possibly refer to the command currently being read from the table. Move on to the next table entry.

                                      repz  cmpsb                           ; Check to see if the received data is the same as the string data corresponding to the command currently being referenced in the table.
                                      jnz   command.help.next.command.jcxnz ; Otherwise, go set up for the next iteration.
                                      jcxz  command.help.found.command      ; Did we get all the way through the string before cmpsb cut us loose? If so, go set up the handler and jump to it.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    command.help.found.command:       pop   ecx                             ; Restore loop counter.
                                      pop   edi                             ; Restore caller's edi register...

                                      mov   ecx, dword [esi]                ; ecx - Pointer to help message.
                                      mov   edx, [ecx-dword.l]              ; edx - Length of message.
                                      pop   esi                             ; esi - Index to socket entry.
                                      
                                      mov   [file.indicator], esi           ; [file.descriptor] - Pointer to active socket.
                                      call  write.descriptor                ; Send the correct help message to the user.
                                      
                                      mov   eax, esi                        ; eax - Pointer to active socket.
                                      call  write.prompt                    ; Send a prompt back to the active user.
                                      
                                      ret                                   ; Return to caller.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    command.help.next.command.jcxnz:  sub   edx, ecx                        ; edx - number of bytes received minus the number of bytes run through by cmpsb before a mismatch was discovered.
                                      mov   edi, ebx                        ; edi - Pointer to received data.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

    command.help.next.command:        add   esi, ecx                        ; esi - Pointer to handler for command currently being referenced in the table.
                                      add   esi, dword.l                    ; esi - Pointer to size of next command in the table.
                                      pop   ecx                             ; Restore loop counter.
                                      loop  command.help.parse.arguments    ; Go check the next command.

                                      pop   edi                             ; Restore caller's edi register.
                                      pop   esi                             ; esi - Index to socket entry.

                                      call  write.bad.help.command.error    ; Let the user know that they've entered a bad command and suggest that they try HELP.

                                      ret                                   ; Return to caller.

    command.help.no.arguments:        call  write.bad.command.error         ; Placeholder function to let me know that no arguments is getting executed.

                                      ret                                   ; Return to caller.
