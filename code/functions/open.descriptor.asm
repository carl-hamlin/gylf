;====================================================================================================================================================================================================
;
;	open.descriptor
;
;	This function calls the linux kernel and causes it to associate a descriptor with an existing file on disk.
;
;	Assumptions:	ebx = Pointer to ASCIIZ formatted file path.
;
;	Returns:	eax = Descriptor associated with file on disk.
;			eax = Error indicator.
;

open.descriptor:	mov	eax, sys.open.call	; eax = Associate a descriptor with a file on disk.
			mov	ecx, sys.read.write	; ecx = Apply read/write permissions to the descriptor.
			sub	edx, edx		; edx = No special modes.
			int	sys.system.call		; Associate a descriptor with a file on disk.
			ret				; Return to caller.
