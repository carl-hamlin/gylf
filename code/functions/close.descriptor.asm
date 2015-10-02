;====================================================================================================================================================================================================
;
;   close.descriptor
;
;   This function tells the linux kernel that we're done making use of an associated descriptor, and that it's time to disassociate it for later use.
;
;   Assumptions:    ebx = Descriptor to be disassociated.
;
;   Returns:        eax = Error indicator.
;

    close.descriptor:  mov  eax, sys.close.call ; eax = Disassociate descriptor specified in ebx.
                       int  sys.system.call     ; Call the kernel and have it perform the disassociation.
                       ret                      ; return to caller.
