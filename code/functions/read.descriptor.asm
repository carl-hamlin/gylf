;====================================================================================================================================================================================================
;
;   read.descriptor
;
;   This function reads data from a descriptor.
;
;   Assumptions:    ebx = Descriptor from which to read.
;                   ecx = Pointer to buffer into which to read the data.
;                   edx = Number of bytes to be read.
;
;   Returns:        eax = Number of bytes read.

    read.descriptor: mov  eax, sys.read.call ; eax = Read data from a descriptor.
                     int  sys.system.call    ; Read data from a descriptor.
                     ret                     ; Return to caller.
