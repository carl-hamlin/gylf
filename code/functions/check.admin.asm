;====================================================================================================================================================================================================
;
;   check.admin
;
;   This function checks to see if the current character is an admin.
;
;   Assumptions:    esi - Index to connection table.
;
;   Returns:        Carry - Admin
;                   No Carry - Not Admin
;

	check.admin:	call	get.character.data		; Populate character data.

			mov	al, byte [administrative.byte]	; al - Administrative byte.
			shr	al, 01h				; Set carry if the least significant bit is high.

			ret					; Return to caller.
