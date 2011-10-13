;====================================================================================================================================================================================================
;
;	write descriptor
;
;	This function writes data to an active descriptor.
;
;	Assumptions:	[file.indicator] = indicator of whether or not a file is associated with the descriptor
;			ecx = Pointer to data to be written.
;			edx = Length of data to be written.
;
;	Returns:	eax = Error indicator.
;

write.descriptor:	mov	eax, sys.write.call				; eax = Write data to an active descriptor.
			mov	ebx, dword [file.indicator]			; ebx = Write to descriptor specified.
			int	sys.system.call					; Write data to an active descriptor.

			mov	dword [file.indicator], sys.standard.output	; Reset the file indicator to default.

			ret							; Return to caller.
