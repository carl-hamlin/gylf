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

    command.help: call  write.bad.command.error ; Let the user know that they've entered a bad command and suggest HELP.
                  ret                           ; Return to caller.
