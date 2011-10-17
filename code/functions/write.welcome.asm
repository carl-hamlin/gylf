;====================================================================================================================================================================================================
;
;   write.welcome
;
;   This function builds the initial welcome screen.
;
;   Assumptions:    esi - Index to connection table.
;
;   Returns:        None.
;

write.welcome:  mov     eax, dword [esi+connection.descriptor.index]    ; eax = Descriptor associated with target connection.
                call    clear.screen                                    ; Clear the user's screen.
        
                mov     eax, dword [esi+connection.descriptor.index]    ; eax - Descriptor associated with target connection.
                call    write.prompt                                    ; Send the prompt to the user.

                ret                                                     ; Return to caller.
