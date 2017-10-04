;====================================================================================================================================================================================================
;
;   accept.socket
;
;   This function calls the linux kernel to associate a descriptor with an incoming Berkeley Socket.
;

accept.socket:  mov     eax, sys.socket.call                        ; eax = linux socket call indicator.
                mov     ebx, sys.socket.accept                      ; ebx = linux socket call accept socket indicator.

                mov     ecx, socket.data.accept.socket.descriptor   ; ecx = pointer to arguments package for linux kernel accept socket function. Package contents are as follows:
                                                                    ;
                                                                    ;     dword    descriptor of listening socket which detected the incoming connection.
                                                                    ;     dword    pointer to sockaddr structure.
                                                                    ;     dword    storage for descriptor of accepted socket.

                int     sys.system.call                             ; Accept the new connection.
                ret                                                 ; Return to caller.
