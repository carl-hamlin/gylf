;====================================================================================================================================================================================================
;
;   ./functions/bail/t
;
;   This function suspends execution and returns control back to linux.
;
;   Assumptions:    None.
;
;   Returns:        None.

    bail: mov  eax, sys.exit.call ; eax = Suspend execution and return control to linux.
          int  sys.system.call    ; Call the kernel and let it know we're done here.
