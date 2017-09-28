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

    %define sys.standard.output 001h  ; 001h is the descriptor we pass to the write function when we want to write to the screen.
    %define socket.number       0FFh  ; Number of sockets represented in table.

    %define dword.l             0004h ; Size of a dword.
    %define word.l              0002h ; Size of a word.
    %define byte.l              0001h ; Size of a byte.
