;==================================================================================================================================================================================================================
;
; gylf
;
; Main loop for server. This is the program's heart.
;
; Assumptions:		None
; Returns:		None
;
; Crossreferencing:	Symbol					Location
;
;			system.check				code/functions/system.check.asm
;			set.up.listener				code/functions/set.up.listener.asm
;			maintain				code/world.maintenance/maintain.asm
;			listening.socket.poll			code/socket/listening.socket.poll.asm
;			active.socket.poll			code/socket/active.socket.poll.asm
;			main.loop				code/gylf.asm


;==================================================================================================================================================================================================================

	section    .bss

	%include    "/home/chamlin/gylf/definitions/include.def"

;==================================================================================================================================================================================================================

	section    .data

	%include    "/home/chamlin/gylf/raw.data/include.dat"

;==================================================================================================================================================================================================================

	section    .text

	%include    "/home/chamlin/gylf/code/include.asm"

	global _start

;==================================================================================================================================================================================================================

	_start:		call	system.check		; Perform a variety of checks to make sure we're ready to go live.
			call	set.up.listener		; Build a listening socket, bind it to a hardware port, tell it to listen for incoming connections, and let the admin know we're online.

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	main.loop:	call	maintain		; Advance a moment in time.
			call	listening.socket.poll	; See if anyone's trying to connect and let them in if so.
			call	active.socket.poll	; See if any active connections are currently transmitting data and if so, act upon it.
			jmp	main.loop		; Another day, another dollar.
