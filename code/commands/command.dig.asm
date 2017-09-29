;================================================================================================================================================================================================
;
;   command.dig.asm
;
;   This function creates an area, if possible. Syntax: dig <direction>
;
;   Assumptions:      eax - Length of received data.
;                     esi - Pointer to descriptor associated with target socket.
;
;   Returns:          None.
;

    command.dig:  call  write.bad.command.error ; Let the user know that they've entered a bad command and suggest HELP.
                  ret                           ; Return to caller.
