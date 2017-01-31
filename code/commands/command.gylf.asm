;================================================================================================================================================================================================
;
;   command.gylf.asm
;
;   This function creates a complete user profile without the intervening process of eggdom.
;
;   Assumptions:     eax - Length of received data.
;                    esi - Pointer to descriptor associated with target socket.
;
;   Returns:         None.
;

    command.gylf: call  write.bad.command.error ; Let the user know that they've entered a bad command and suggest HELP.
                  ret                           ; Return to caller.
