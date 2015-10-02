;==================================================================================================================================================================================================================
;
;   aggregate.arguments.asm
;
;   This file contains code pertinent to the separation and filing of commands and arguments received from an incoming socket.
;
;   Assumptions: esi - Pointer to data received from the socket.
;   Returns:     aggregated arguments at [argument.packet]
;

    aggregate.arguments:                        push eax                                        ; Preserve caller's eax register.
                                                push ebx                                        ; Preserve caller's ebx register.
                                                push esi                                        ; Preserve pointer to data received from the socket.

                                                sub  eax, eax                                   ; eax - Prepared to be used for counting.

                                                mov  ebx, argument.01.location                  ; ebx - Pointer to first location.
                                                mov  [ebx], esi                                 ; Populate location of first argument.

    aggregate.arguments.loop:                   cmp  byte [esi], '"'                            ; Are we looking at a quotation mark?
                                                jz   aggregate.arguments.quote.mode             ; Yes - this is a special case argument. Go treat it as such.

                                                cmp  byte [esi], 20h                            ; Are we looking at a space?
                                                jz   aggregate.arguments.prep.for.next.argument ; Yes - under normal circumstances, this indicates a new argument.

                                                cmp  byte [esi], 00h                            ; Are we looking at a zero terminator?
                                                jz   aggregate.arguments.prep.for.next.argument ; Yes - this indicates that we're finished.

                                                inc  esi                                        ; esi - Pointer to next byte in argument.
                                                inc  al                                         ; al - Incremented to reflect an additional byte in the size of the argument.

                                                jmp  aggregate.arguments.loop                   ; Go check the next byte.

    aggregate.arguments.prep.for.next.argument: inc  esi                                        ; esi - Pointer to next argument or terminator.
                                                inc  ah                                         ; ah - Incremented to indicate an increase in the number of arguments.
                                                mov  [ebx-1], al                                ; Store size of argument recently examined.
                                                sub  al, al                                     ; al - Prepared to be used for counting.

                                                cmp  byte [esi], 00h                            ; Are we looking at a zero terminator?
                                                jz   aggregate.arguments.arguments.aggregated   ; Yes - We're done here.

                                                add  ebx, argument.entry.size                   ; ebx - Pointer to next argument entry.
                                                mov  [ebx], esi                                 ; Store location of next argument.

                                                jmp  aggregate.arguments.loop                   ; Go check the next argument.

    aggregate.arguments.arguments.aggregated:   mov  [arguments.num], ah                        ; Store the number of arguments.

                                                pop  esi                                        ; Restore pointer to data received from the socket.
                                                pop  ebx                                        ; Restore caller's ebx register.
                                                pop  eax                                        ; Restore caller's eax register.

                                                ret                                             ; Return to caller.

    aggregate.arguments.quote.mode:             dec  al                                         ; al - Decremented to offset first loop iteration.
    aggregate.arguments.quote.mode.l:           inc  esi                                        ; esi - Pointer to next byte in quited argument
                                                inc  al                                         ; al - Incremented to reflect an additional byte in the size of the argument.

                                                cmp  byte [esi], '"'                            ; Have we found the terminating quotation mark?
                                                jnz  aggregate.arguments.quote.mode.l           ; No. Go check the next byte.

                                                inc  esi                                        ; esi - Pointer to delineator between this argument and the next, or terminator.

                                                jmp  aggregate.arguments.prep.for.next.argument ; Go see if we have another argument.
