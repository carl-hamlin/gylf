;====================================================================================================================================================================================================
;
;   ./b
;
;   This file contains shared definitions for downstream functions.
;
;----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;
;   Symbolic Cross-Reference
;
;   No external references.
;

    %define sys.standard.output    001h ; 001h is the descriptor we pass to the write function when we want to write to the screen.
    %define dead.socket           0000h ; Number of sockets represented in table.

    %define dword.l               0004h ; Size of a dword.
    %define word.l                0002h ; Size of a word.
    %define byte.l                0001h ; Size of a byte.

    e.data            resb  egg_size    ; Storage for egg data.
    d.data            resb  ghost_size  ; Storage for ghost data.
    g.data            resb  gylf_size   ; Storage for participant data.

    a.p.data          resb  gylf_size   ; Storage for active participant data.
