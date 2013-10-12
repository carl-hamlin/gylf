;==================================================================================================================================================================================================================
;
; command.logout
;
; Logs a participant out of the server but leaves their avatar active and under the control of the artificial intelligence.
;
; Syntax:
;
; logout
;
; Assumptions: esi - Pointer to descriptor associated with active socket.
;
; Returns: None.
;

	command.logout:	ret	; Return to caller
