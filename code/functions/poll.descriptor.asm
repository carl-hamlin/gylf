;====================================================================================================================================================================================================
;
;	poll.descriptor
;
;	This function asks a connected socket if it has data on it that needs attention.
;
;	Assumptions:	ebx = Pointer to arguments package structured as follows:
;				dword	Descriptor associated with active, bound and listening socket.
;				dword	Requested event(s).
;				dword	Storage for returned event(s)
;
;			ecx = Number of descriptors to be polled.
;			edx = Length of time in milliseconds to wait for a response.
;
;	Returns:	eax = Returned event(s)
;

poll.descriptor:	mov	eax, sys.poll.call	; eax = Ask a connected socket if it has data on it.
			int	sys.system.call		; Ask a connected socket if it has data on it.
			ret				; Return to caller.
