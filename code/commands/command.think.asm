;================================================================================================================================================================================================
;
;   command.look.asm
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

command.think:      ret     ; Do nothing for the moment.
