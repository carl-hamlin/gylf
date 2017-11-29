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
;   ./s egg_size
;       ghost_size
;       gylf_size
;       login_size
;

    %define sys.standard.output    001h ; 001h is the descriptor we pass to the write function when we want to write to the screen.
    %define dead.socket           0000h ; Number of sockets represented in table.

    %define dword.l               0004h ; Size of a dword.
    %define word.l                0002h ; Size of a word.
    %define byte.l                0001h ; Size of a byte.

    %define a.p.type.egg            00h ; Active participant type - Egg.
    %define a.p.type.ghost          01h ; Active participant type - Ghost.
    %define a.p.type.gylf           02h ; Active participant type - Gylf.
    %define a.p.type.login          03h ; Active participant type - Login.

    e.data            resb  egg_size    ; Storage for egg data.
    d.data            resb  ghost_size  ; Storage for ghost data.
    g.data            resb  gylf_size   ; Storage for participant data.
    l.data            resb  login_size  ; Storage for login data.

    a.p.data.egg      resb  egg_size    ; Storage for active egg data.
    a.p.data.ghost    resb  ghost_size  ; Storage for active ghost data.
    a.p.data.gylf     resb  gylf_size   ; Storage for active gylf data.
