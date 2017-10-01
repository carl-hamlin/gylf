;==================================================================================================================================================================================================================
;
;   command.logout
;
;   Logs a participant out of the server but leaves their avatar active and under the control of the artificial intelligence.
;
;   Syntax: logout
;
;   Assumptions:     esi - Pointer to descriptor associated with active socket.
;
;   Returns:         None.
;

	command.logout:	call  write.bad.command.error ; Let the user know that they've entered a bad command and suggest HELP.
	                ret	                          ; Return to caller
