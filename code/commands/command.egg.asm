;================================================================================================================================================================================================
;
;   command.egg.asm
;
;   This function creates a fertilized egg for a new user.
;
;   Assumptions:     eax - Length of received data.
;                    esi - Pointer to descriptor associated with target socket.
;
;   Returns:         None.
;

    command.egg:  call  write.bad.command.error ; Let the user know that they've entered a bad command and suggest HELP.
                  ret                           ; Return to caller.
