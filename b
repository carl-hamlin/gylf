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


    %define char.0              030h  ; Zero
    %define char.1              031h  ; One
    %define char.2              032h  ; Two
    %define char.3              033h  ; Three
    %define char.4              034h  ; Four
    %define char.5              035h  ; Five
    %define char.6              036h  ; Six
    %define char.7              037h  ; Seven
    %define char.8              038h  ; Eight
    %define char.9              039h  ; Nine

    %define char.A              041h  ; Ten
    %define char.B              042h  ; Eleven
    %define char.C              043h  ; Twelve
    %define char.D              044h  ; Thirteen
    %define char.E              045h  ; Fourteen
    %define char.F              046h  ; Fifteen

    %define qword.l             0008h ; Size of a qword.
    %define dword.l             0004h ; Size of a dword.
    %define word.l              0002h ; Size of a word.
    %define byte.l              0001h ; Size of a byte.

    %define nibble.l            0004h ; Size of a nibble.
