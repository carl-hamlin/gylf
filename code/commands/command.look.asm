;================================================================================================================================================================================================
;
;	command.look.asm
;
;	This function displays information about the target.
;
;	Syntax:
;	look
;
;	Displays information about the current area.
;
;	look <target>
;
;	Displays information about the target.
;
;	Assumptions:	eax - Length of received data.
;			esi - Pointer to descriptor associated with target socket.
;
;	Returns:	None.
;

command.look:				cmp	eax, command.look.l								; Has the user invoked the command with no arguments?
					jz	command.look.default								; Yes. Go execute default behaviour.

					; Here's where the targetted code goes.

					mov	ebx, esi									; ebx - Pointer to descriptor associated with target socket.
					add	ebx, connection.area.id.index							; ebx - Pointer to area id associated with active connection.

					call	open.descriptor									; Associate a descriptor with the area id.

					or	eax, eax									; Did the descriptor associate properly?
					jnz	command.look.targetted.good.descriptor						; Yes. Go have a look at contained objects.

					jmp	command.look.bad.descriptor							; No. Go inform the user that the descriptor is invalid.

command.look.targetted.good.descriptor:	mov	ebx, eax									; Descriptor associated with area id.
					mov	ecx, area.header								; ecx - Pointer to storage for area header.
					mov	edx, area.header.l								; edx - Length of area header.

					call	read.descriptor									; Read area header from descriptor associated with area id.

					mov	ecx, dword [area.num.contained.items]						; ecx - number of items to check targetting argument against.

command.look.targetted.find.target:	push	ecx										; Preserve number of items.

					mov	ecx, buffer.1									; ecx - Pointer to buffer into which to read item id.
					mov	edx, dword.l									; edx - Length of item id.

					call	read.descriptor									; Read an item id.

					pop	ecx										; Restore number of items.

					loop	command.look.targetted.find.target						; Go check the next item.

					ret											; Return to caller.

command.look.default:			mov	ebx, esi									; ebx - Index to connection table entry.
					add	ebx, connection.area.id.index							; ebx - Pointer to area id associated with active connection.

					call	open.descriptor									; Associate a descriptor with the file containing current area info.

					or	eax, eax									; Were we able to properly associate a descriptor?
					jnz	command.look.default.good.descriptor						; Yes. Go execute default behaviour.

command.look.bad.descriptor:		mov	ecx, local.data.bad.area.id.indicator.message					; No. ecx - pointer to message indicating the local area id is bad.
					mov	edx, local.data.bad.area.id.indicator.message.l					; edx - Length of message.
					call	write.descriptor								; Tell the admin that the local area id got screwed up somehow.

					mov	ebx, dword [esi+connection.descriptor.index]					; ebx - Pointer to descriptor associated with active connection.
					mov	dword [socket.data.send.socket.descriptor], ebx					; Point socket.send to the descriptor associated with the active
																; connection.
					mov	dword [socket.data.send.buffer.pointer], socket.data.bad.area.id.message	; Point socket.send to the remote bad area id message.
					mov	dword [socket.data.send.buffer.l], socket.data.bad.area.id.message.l		; Tell socket.send the length of the message.
					call	socket.send									; Put the message on the socket.

					call	write.prompt									; Restore the user's prompt.

					ret											; Return to caller.

command.look.default.good.descriptor:	mov	ebx, eax									; ebx - Descriptor associated with area file.
					mov	ecx, buffer.1									; ecx - Pointer to buffer into which to read the length of he area
																; name entry.
					mov	edx, dword.l									; edx - Dword length.
					call	read.descriptor									; Read the length of the name entry.

					mov	ecx, buffer.1									; ecx - Pointer to buffer into which to read the name entry.
					mov	edx, dword [buffer.1]								; edx - Length of the name entry.
					call	read.descriptor									; Read the name entry.

					mov	ecx, buffer.1									; ecx - Pointer to buffer into which to read the length of the
																; description entry.
					mov	edx, dword.l									; edx - Dword length.
					call	read.descriptor									; Read the length of the description entry.

					mov	ecx, buffer.1									; ecx - Pointer to buffer into which to read the description entry.
					mov	edx, dword [buffer.1]								; edx - Length of the description entry.
					call	read.descriptor									; Read the description entry.

					call	close.descriptor								; Disassociate the descriptor currently associated with the current
																; area file.

					mov	ebx, dword [esi+connection.descriptor.index]					; ebx - Descriptor associated with the current active connection.
					mov	dword [socket.data.send.socket.descriptor], ebx					; Point socket.send to the current connection.
					mov	dword [socket.data.send.buffer.pointer], buffer.1				; Point socket.send to the description entry.
					mov	dword [socket.data.send.buffer.l], eax						; Tell socket.send the length of the message.
					call	socket.send									; Put the message on the socket.

					call	write.prompt									; Restore the user's prompt.

					ret											; Return to caller.
