;================================================================================================================================================================================================
;
;   command.think.asm
;
;   This function is used by players and admins to communicate with one another.
;
;   Syntax:
;   think
;
;       Broadcasts a message to the area.
;
;   think <target>
;
;       Attempts to isolate a message to a particular recipient, with a chance for overflow.
;
;   Assumptions:    eax - Length of received data.
;                   esi - Pointer to descriptor associated with target socket.
;
;   Returns:        None.
;

command.think:              mov     ecx, buffer.1                                                           ; ecx - Pointer to received command string.
                            add     ecx, command.think.l                                                    ; ecx - Pointer to first argument for command.

                            mov     ebx, ecx                                                                ; ebx - Pointer to first argument for command.
                            inc     ebx                                                                     ; ebx - Pointer to first byte of first argument.
                            cmp     byte [ebx], '"'                                                         ; Is the first byte a quotation mark?
                            jz      command.think.untargetted                                               ; Yes - send the message to the entire area.

                            ; Skill evaluation goes here - failure shunts to command.think.untargetted.
                            
                            ; TODO - Figure out how to get a valid connection ID from user input to send in eax.

                            call    send.to.player                                                          ; Send message to targetted player.

                            ret                                                                             ; Return to caller.

command.think.untargetted:  mov     edx, eax                                                                ; edx - Length of command string minus terminator(s).
                            sub     edx, command.think.l                                                    ; edx - Length of command string minus terminator(s) and command.
                            call    send.to.area                                                            ; Broadcast the message.

                            ret                                                                             ; Return to caller.
