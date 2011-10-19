;=================================================================================================================================================================================================
;
;   socket.errors
;
;   These code snippets setup error messages to be displayed to the admin in the event that something goes awry while building the listening socket. If any of these are ever executed, we're
;   beyond the point of no return, so each of them passes control to the bail function after displaying their unique message.
;
;   Assumptions:    None.
;
;   Returns:        None.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

socket.create.error:    mov     ecx, local.data.create.error.message    ; ecx = Pointer to socket creation failure error message.
                        mov     edx, local.data.create.error.message.l  ; edx = Length of message.
                        call    write.descriptor                        ; Display the message to the admin.

                        jmp     bail                                    ; Return control to linux.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

socket.bind.error:      mov     ecx, local.data.bind.error.message      ; ecx = Pointer to bind failure error message.
                        mov     edx, local.data.bind.error.message.l    ; edx = Length of message.
                        call    write.descriptor                        ; Display the message to the admin.

                        jmp     bail                                    ; Return control to linux.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

socket.listen.error:    mov     ecx, local.data.listen.error.message    ; ecx = Pointer to listen failure error message.
                        mov     edx, local.data.listen.error.message.l  ; edx = Length of message.
                        call    write.descriptor                        ; Display the message to the admin.

                        jmp     bail                                    ; Return control to linux.

;-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

socket.accept.error:    mov     ecx, local.data.accept.error.message    ; ecx = Pointer to accept failure error message.
                        mov     edx, local.data.accept.error.message.l  ; edx = Length of message.
                        call    write.descriptor                        ; Display the message to the admin.

                        jmp     bail                                    ; Return control to linux.
