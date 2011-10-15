;====================================================================================================================================================================================================
;
;   create.file
;
;   This function calls the kernel to build a file on disk and associate a descriptor with it.
;
;   Assumptions:    ebx = Pointer to ASCIIZ formatted file path.
;
;   Returns:        eax = Descriptor associated with the new file.
;                   eax = Error indicator.
;

create.file:    mov     eax, sys.create.call    ; eax = Build a file on disk and associate a descriptor with it.
                mov     ecx, sys.read.write     ; ecx = Apply read/write access permissions to the built file.
                sub     edx, edx                ; edx = No special modes.
                int     sys.system.call         ; Build a file on disk and associate a descriptor with it.
                ret                             ; Return to caller.
