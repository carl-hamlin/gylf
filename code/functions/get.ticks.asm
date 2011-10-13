;====================================================================================================================================================================================================
;
;	get.ticks
;
;	This function returns the number of clock ticks since boot time.
;
;	Assumptions:	ebx - null if results to be included in eax.
;			ebx - pointer to buffer for results if results not only to be included in eax.
;
;	Returns:	eax - number of clock ticks since boot time.
;			[ebx] - number of clock ticks since boot time if function entered with non-null ebx.
;

get.ticks:	mov	eax, sys.get.ticks	; eax - get number of ticks since boot time.
		int	sys.system.call		; get the numberof ticks since boot time and put them in the eax register.
		ret				; Return to caller.
